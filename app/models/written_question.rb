# encoding: UTF-8
# == Schema Information
#
# Table name: written_questions
#
#  id              :integer          not null, primary key
#  question        :text
#  answer          :text
#  status          :string(255)
#  question_number :integer
#  question_year   :integer
#  asker_id        :integer
#  portfolio_id    :integer
#  respondent_id   :integer
#  date_asked      :date
#  days_late       :integer
#  subject         :string(255)
#  portfolio_name  :string(255)
#

class WrittenQuestion < ActiveRecord::Base
  belongs_to :asker, :class_name => "Mp"
  belongs_to :portfolio
  belongs_to :respondent, :class_name => "Mp"

  has_many :written_questions_links, :foreign_key => :from_id
  has_many :linked_questions, :class_name => "written_question", :through => :written_question_links

  validates_presence_of :question, :asker, :portfolio, :question_number, :question_year
end
