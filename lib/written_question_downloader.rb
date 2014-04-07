# encoding: UTF-8
require 'rubygems'
require 'open-uri'
require 'hpricot'

class WrittenQuestionDownloader
  STATUSES = ["Question", "Reply"]

  def download
    finished = false
    page = 0
    questions = questions_in_index(page)

    earliest_query = WrittenQuestion.find(:first, :limit => 1, :conditions => ['status = ?', 'question'], :order => 'question_number')
    @earliest_question_no = earliest_query.nil? ? 0 : earliest_query.question_number

    while !questions.empty? and !finished
      finished = download_questions(questions)
      page = page.next
      questions = questions_in_index(page)
    end

    PersistedFile.set_written_indexes_on_date
  end

  def open_index_page page
    # url = "http://www.parliament.nz/en-NZ/PB/Debates/QWA/Default.htm?search=1232319134&p=#{page}"
    url = "http://www.parliament.nz/en-NZ/PB/Debates/QWA/Default.htm?p=#{page}"
    # puts "opening #{url}"
    Hpricot open(url)
  end

  def questions_in_index page
    doc = open_index_page page
    (doc/'.listing tbody tr')
  end

  def download_questions questions
    finished = false
    questions.each do |question|
      unless finished
        finished = download_question(question)
      end
    end
    finished
  end

  def download_question question
    date = date_question question
    status = get_status question
    question_number = get_question_number question

    if question_number > @earliest_question_no and STATUSES.include?(status)
      finished = continue_download question, date, status
    end
    if question_number < @earliest_question_no
      finished = true
    end
    finished
  end

  def continue_download question, date, status
    persisted_file = PersistedFile.new({
        :debate_date => date,
        :oral_answer => @downloading_uncorrected,
        :parliament_name => question_name(question),
        :parliament_url => question_url(question),
        :written_status => status,
        :publication_status => 'W'
      })

    download_if_new persisted_file
    finished = false
    finished
  end

  def question_name question
    question.at("h4 a").inner_html
  end

  def download_if_new persisted_file
    finished = false
    if persisted_file.exists?
      PersistedFile.add_if_missing persisted_file
    else
      download_this_question persisted_file
    end
    finished
  end

  def download_this_question persisted_file
    contents = question_contents(persisted_file.parliament_url)

    if contents.include? 'Server Error'
      PersistedFile.add_non_downloaded persisted_file
    else
      if persisted_file.exists?
        PersistedFile.add_if_missing persisted_file
      else
        PersistedFile.add_new persisted_file, contents
      end
    end
  end

  def question_contents url
    contents = nil
    open(url) { |io| contents = io.read }
    contents
  end


  def question_url question
    "http://www.parliament.nz#{question.at("h4 a").attributes["href"]}"
  end

  def get_question_number question
    question.at('h4 a').inner_html.to_i
  end

  def get_status question
    question.at('.attrStatus').inner_html
  end

  def date_question question
    content = question.at('.attrPublicationDate').inner_html
    date = Date.parse("#{content[0,6]} 20#{content[7,2]}")
  end
end
