# encoding: UTF-8
# == Schema Information
#
# Table name: pecuniary_interests
#
#  id                    :integer          not null, primary key
#  pecuniary_category_id :integer          not null
#  mp_id                 :integer          not null
#  item                  :text             not null
#

class PecuniaryInterest < ActiveRecord::Base

  belongs_to :pecuniary_category
  belongs_to :mp

end
