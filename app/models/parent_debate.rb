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

class ParentDebate < Debate

  before_validation :populate_sub_debate

  has_many :sub_debates, :class_name => 'SubDebate',
           :order => 'debate_index',
           :foreign_key => 'debate_id',
           :dependent => :destroy

  def is_parent_with_one_sub_debate?
    sub_debates.size == 1
  end

  def last_debate_index
    sub_debates.last.debate_index
  end

  def sub_debate
    sub_debates.first
  end

  def category
    'debate'
  end

  def next_index
    if sub_debates.size == 1
      index.next.next
    else
      index.next
    end
  end

  def sub_names= names
    @sub_names = names
  end

  def sub_name= name
    @sub_names = [name]
  end

  protected

    def make_url_slug_text
      '' # slugs are set on the sub-debates
    end

    def populate_sub_debate type=SubDebate
      if @sub_names
        @sub_names.each_with_index do |sub_name, index|
          sub_debate = type.new :name => sub_name,
              :date => date,
              :publication_status => publication_status,
              :css_class => 'subdebate',
              :debate_index => debate_index + 1 + index,
              :source_url => source_url,
              :hansard_volume => hansard_volume
          sub_debate.debate = self
          self.sub_debates << sub_debate
        end
        @sub_names = nil
      end
    end
end
