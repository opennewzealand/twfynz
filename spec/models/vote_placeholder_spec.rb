# == Schema Information
#
# Table name: contributions
#
#  id           :integer          not null, primary key
#  spoken_in_id :integer          not null
#  spoken_by_id :integer
#  type         :string(255)      not null
#  speaker      :string(255)
#  on_behalf_of :string(255)
#  time         :time
#  page         :integer
#  vote_id      :integer
#  text         :text             not null
#  date         :date
#  date_int     :integer
#

require 'spec_helper'

describe VotePlaceholder do

  describe 'when asked for bill' do
    it 'should look ask debate for bill' do
      bill = double('bill')
      debate = double('debate', :bill => bill)
      placeholder = VotePlaceholder.new
      placeholder.stub(:debate).and_return debate
      placeholder.bill.should == bill
    end
  end
end
