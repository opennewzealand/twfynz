# == Schema Information
#
# Table name: debate_topics
#
#  id         :integer          not null, primary key
#  debate_id  :integer          not null
#  topic_type :string(15)
#  topic_id   :integer          not null
#

require 'spec_helper'

describe DebateTopic do

  describe 'when asked for formerly_part_of_bill' do
    it 'should look ask contribution for bill' do
      former_bill = double('former_bill')
      bill = double('bill', :formerly_part_of => former_bill)
      bill.should_receive(:is_a?).with(Bill).and_return true
      debate_topic = DebateTopic.new
      debate_topic.stub(:topic).and_return bill
      debate_topic.formerly_part_of_bill.should == former_bill
    end
  end
end
