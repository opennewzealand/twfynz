# == Schema Information
#
# Table name: votes
#
#  id                :integer          not null, primary key
#  type              :string(12)
#  vote_question     :text
#  vote_result       :text
#  ayes_tally        :integer
#  noes_tally        :integer
#  abstentions_tally :integer
#

require 'spec_helper'

describe Vote do

  describe 'when asked for bill' do
    it 'should look ask contribution for bill' do
      bill = double('bill')
      contribution = double('contribution', :bill => bill)
      vote = Vote.new
      vote.stub(:contribution).and_return contribution
      vote.bill.should == bill
    end
  end

  describe 'on creation' do
    it 'should default tally of ayes to zero' do
      vote = Vote.new :noes_tally => 1, :abstentions_tally => 1
      vote.valid?
      vote.ayes_tally.should == 0
      vote.noes_tally.should == 1
      vote.abstentions_tally.should == 1
    end

    it 'should default tally of noes to zero' do
      vote = Vote.new :ayes_tally => 1, :abstentions_tally => 1
      vote.valid?
      vote.ayes_tally.should == 1
      vote.noes_tally.should == 0
      vote.abstentions_tally.should == 1
    end

    it 'should default tally of abstentions to zero' do
      vote = Vote.new :ayes_tally => 1, :noes_tally => 1
      vote.valid?
      vote.ayes_tally.should == 1
      vote.noes_tally.should == 1
      vote.abstentions_tally.should == 0
    end
  end

end
