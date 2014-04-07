# encoding: UTF-8
# == Schema Information
#
# Table name: debates
#
#  id                 :integer          not null, primary key
#  date               :date             not null
#  debate_index       :integer          not null
#  publication_status :string(1)        not null
#  source_url         :string(255)
#  type               :string(255)      not null
#  hansard_volume     :integer
#  start_page         :integer
#  name               :string(255)      not null
#  css_class          :string(255)      not null
#  debate_id          :integer
#  about_type         :string(255)
#  about_id           :integer
#  about_index        :integer
#  answer_from_type   :string(255)
#  answer_from_id     :integer
#  oral_answer_no     :integer
#  re_oral_answer_no  :integer
#  url_slug           :string(255)
#  url_category       :string(255)
#

class OralAnswer < SubDebate

  before_validation :populate_sub_debate

  belongs_to :answer_from, :polymorphic => true

  def category
    @debate.name.downcase
  end

  def title_name s=':'
    name.gsub(/\s-([A-Z0-9])/,s+' \1').gsub(/-\s([A-Z0-9])/,s+' \1').gsub(/-([A-Z0-9])/, s+' \1').sub('Benson'+s+' Pope','Benson-Pope').sub('Auditor'+s+' General','Auditor-General').sub('United States '+s+' New Zealand', 'United States - New Zealand').sub('Pupil'+s+' Teacher Ratios','Pupil-Teacher Ratios')
  end

  def index_prefix
    'o'
  end

  def create_url_slug
    populate_url_slug make_url_slug_text.gsub(' and ',' ')
    self.url_slug
  end

  def questions
    contributions.select {|o| o.is_question? }
  end

  class << self
    def recent limit = 20
      limit(limit).order("date DESC")
    end
  end

  def question_to= name
    @question_to = name
  end

  protected

    def find_by_candidate_slug candidate_slug
      OralAnswer.find_by_url_slug_and_date_and_publication_status_and_about_type_and_about_id(candidate_slug, date, publication_status, about_type, about_id)
    end

    def make_url_slug_text
      if name.include?("—")
        major, minor = name.parameterize.split("—")
        text = matches_about_name_or_minister_name(major) ? minor : major
      else
        text = name.parameterize
      end
    end

    def populate_sub_debate
      unless @question_to.blank?
        question_to = @question_to
        if question_to.index(/Bill(\)| \(No \d+\))?$/)
          name = question_to.sub('Member in charge of the ','').sub('Member in charge of ','')
          if (bill = Bill.from_name_and_date(name, self.date))
            self.answer_from_type = Mp.name
            self.answer_from_id = bill.member_in_charge.id
            self.about_type = Bill.name
            self.about_id = bill.id
          else
            raise "can't find bill from: " + name
          end
        elsif question_to.ends_with? 'Committee'
          if (chair = CommitteeChair.from_name question_to)
            self.answer_from_type = CommitteeChair.name
            self.answer_from_id = chair.id
            self.about_type = Committee.name
            self.about_id = chair.committee.id
          else
            raise "can't find committee chair from: " + question_to
          end
        elsif (minister = Minister.from_name(question_to))
          self.answer_from_type = Minister.name
          self.answer_from_id = minister.id
          self.about_type = Portfolio.name
          self.about_id = minister.portfolio.id
        else
          raise "can't find answer_from_type for: " + question_to
        end
        @question_to = nil
      end
    end
  private

    def matches_about_name_or_minister_name text
      about && ( (text.gsub(',','') == about.full_name.gsub(',','') ) || (text =~ /#{about.full_name}, (Associate )?Minister/) )
    end
end
