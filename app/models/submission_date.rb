# encoding: UTF-8
# == Schema Information
#
# Table name: submission_dates
#
#  id             :integer          not null, primary key
#  parliament_url :string(255)      not null
#  committee_id   :integer
#  bill_id        :integer          not null
#  date           :date
#  title          :string(255)      not null
#  details        :string(255)      not null
#

class SubmissionDate < ActiveRecord::Base
  belongs_to :bill
  belongs_to :committee

  def self.find_live_bill_submissions
    submissions = find(:all, :include => :bill).select{|sd| sd.date >= Date::today}
    bills = submissions.collect(&:bill_id).uniq
    unique = []
    submissions.each do |submission|
      if bills.include? submission.bill_id
        unique << submission
        bills.delete(submission.bill_id)
      end
    end
    unique.sort {|a,b| ((a.date <=> b.date) == 0) ? a.title <=> b.title : a.date <=> b.date }
  end
end
