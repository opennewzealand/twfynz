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

require 'spec_helper'

describe ParentDebate, 'when it has a single sub_debate' do
  it 'should identify itself as a parent debate with a single sub_debate' do
    debate = ParentDebate.new
    sub_debate = double(SubDebate)
    debate.stub(:sub_debates).and_return [sub_debate]
    debate.is_parent_with_one_sub_debate?.should be_true
  end
end
