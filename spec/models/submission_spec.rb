# == Schema Information
#
# Table name: submissions
#
#  id                   :integer          not null, primary key
#  submitter_name       :string(255)
#  submitter_url        :string(255)
#  business_item_name   :string(255)
#  committee_id         :integer
#  date                 :date
#  evidence_url         :string(255)
#  business_item_type   :string(255)
#  business_item_id     :integer
#  is_from_organisation :boolean
#  submitter_type       :string(255)
#  submitter_id         :integer
#

require 'spec_helper'

describe Submission do

  it "should be valid" do
    committee_name = 'Commerce Committee'
    item_name = 'Regulatory Responsibility Bill'
    date = Date.parse('2007-09-29')

    committee = mock_model(Committee)
    committee.should_receive(:id).and_return(1)
    Committee.should_receive(:from_name).with(committee_name).and_return(committee)

    bill = mock_model(Bill)
    bill.should_receive(:id).and_return(2)
    Bill.should_receive(:from_name_and_date).with(item_name, date).and_return(bill)

    submission = Submission.new :business_item_name => item_name,
      :date => date.to_s
    submission.committee_name = committee_name
    submission.should be_valid
    submission.committee_id.should == 1
    submission.business_item_id.should == 2
    submission.business_item_type.should == Bill.name
  end

  it "should be valid without matching business item" do
    committee_name = 'Commerce Committee'
    item_name = 'Inquiry into housing affordability in New Zealand'
    date = Date.parse('2007-09-29')

    committee = mock_model(Committee)
    committee.should_receive(:id).and_return(1)
    Committee.should_receive(:from_name).with(committee_name).and_return(committee)

    submission = Submission.new :business_item_name => item_name,
      :date => date.to_s
    submission.committee_name = committee_name
    submission.should be_valid
    submission.committee_id.should == 1
    submission.business_item_id.should == nil
    submission.business_item_type.should == nil
  end

end
