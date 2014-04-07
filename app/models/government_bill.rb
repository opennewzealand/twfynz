# encoding: UTF-8
# == Schema Information
#
# Table name: bills
#
#  id                                      :integer          not null, primary key
#  url                                     :text
#  bill_no                                 :string(8)
#  formerly_part_of_id                     :integer
#  member_in_charge_id                     :integer
#  referred_to_committee_id                :integer
#  type                                    :string(15)       not null
#  bill_name                               :string(155)      not null
#  parliament_url                          :string(255)      not null
#  parliament_id                           :string(255)      not null
#  introduction                            :date
#  first_reading                           :date
#  first_reading_negatived                 :boolean          not null
#  first_reading_discharged                :date
#  submissions_due                         :date
#  sc_reports_interim_report               :date
#  sc_reports                              :date
#  sc_reports_discharged                   :date
#  consideration_of_report                 :date
#  consideration_of_report_discharged      :date
#  second_reading                          :date
#  second_reading_negatived                :boolean          not null
#  second_reading_discharged               :date
#  committee_of_the_whole_house            :date
#  committal_discharged                    :date
#  third_reading                           :date
#  royal_assent                            :date
#  withdrawn                               :date
#  former_name                             :string(155)
#  act_name                                :string(155)
#  description                             :text
#  earliest_date                           :date             not null
#  second_reading_withdrawn                :date
#  plain_bill_name                         :string(255)
#  plain_former_name                       :string(255)
#  committee_of_the_whole_house_discharged :date
#  formerly_part_of_text                   :string(255)
#

class GovernmentBill < Bill

end
