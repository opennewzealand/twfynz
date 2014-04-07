# == Schema Information
#
# Table name: parliaments
#
#  id                                   :integer          not null, primary key
#  ordinal                              :string(255)
#  commission_opening_date              :date
#  commission_opening_debate_id         :integer
#  dissolution_date                     :date
#  wikipedia_url                        :string(255)
#  party_votes_count                    :integer
#  bill_final_reading_party_votes_count :integer
#

require 'spec_helper'

describe Parliament do

  assert_model_has_many :members
  assert_model_belongs_to :commission_opening_debate

  before(:each) do
    @parliament = Parliament.new
  end

  it "should be valid" do
    @parliament.should be_valid
  end
end
