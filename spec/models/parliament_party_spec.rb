# == Schema Information
#
# Table name: parliament_parties
#
#  id                                   :integer          not null, primary key
#  parliament_id                        :integer
#  party_id                             :integer
#  parliament_description               :text
#  in_parliament_text                   :text
#  parliament_agreements_text           :text
#  agreements_file                      :string(255)
#  parliament_url                       :string(255)
#  wikipedia_url                        :string(255)
#  party_votes_count                    :integer
#  bill_final_reading_party_votes_count :integer
#

require 'spec_helper'

describe ParliamentParty do

  assert_model_belongs_to :party
  assert_model_belongs_to :parliament

  before(:each) do
    @parliament_party = ParliamentParty.new
  end

  it "should be valid" do
    @parliament_party.should be_valid
  end
end
