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

require 'spec_helper'

describe WrittenQuestion do
  before do
    @asker = Mp.new
    @portfolio = Portfolio.new
    @attributes = {
      :asker => @asker,
      :portfolio => @portfolio,
      :question => "lolwhut?",
      :question_number => 1,
      :question_year => 1999
    }
    @question = WrittenQuestion.new
  end

  it "should be valid with valid information" do
    @question.attributes = @attributes
    @question.should be_valid
  end

  it "should not be valid without an asker" do
    @question.attributes = @attributes.except(:asker)
    @question.should have(1).error_on(:asker)
  end

  it "should not be valid without a portfolio" do
    @question.attributes = @attributes.except(:portfolio)
    @question.should have(1).error_on(:portfolio)
  end

  it "should not be valid without a question" do
    @question.attributes = @attributes.except(:question)
    @question.should have(1).error_on(:question)
  end

  it "should not be valid without a question_number" do
    @question.attributes = @attributes.except(:question_number)
    @question.should have(1).error_on(:question_number)
  end

  it "should not be valid without a question_year" do
    @question.attributes = @attributes.except(:question_year)
    @question.should have(1).error_on(:question_year)
  end
end
