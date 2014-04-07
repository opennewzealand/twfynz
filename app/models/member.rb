# encoding: UTF-8
# == Schema Information
#
# Table name: members
#
#  id                        :integer          not null, primary key
#  person_id                 :integer
#  electorate                :string(255)
#  party_id                  :integer
#  from_date                 :date
#  to_date                   :date
#  from_what                 :string(255)
#  list_member_vacancy_url   :string(255)
#  members_sworn_url         :string(255)
#  maiden_statement_url      :string(255)
#  to_what                   :string(255)
#  membership_change_url     :string(255)
#  resignation_url           :string(255)
#  valedictory_statement_url :string(255)
#  replaced_by_id            :integer
#  term                      :integer
#  created_at                :datetime
#  updated_at                :datetime
#  parliament_id             :integer
#  image                     :string(255)
#

class Member < ActiveRecord::Base

  belongs_to :parliament
  belongs_to :party
  belongs_to :person, :class_name => 'Mp'
  belongs_to :replaced_by, :class_name => 'Mp'

  def maiden_statement_date
    maiden_statement_url ? date_from_url(maiden_statement_url) : nil
  end

  def members_sworn_date
    members_sworn_url ? date_from_url(members_sworn_url) : nil
  end

  def resignation_date
    resignation_url ? date_from_url(resignation_url) : nil
  end

  def valedictory_statement_date
    valedictory_statement_url ? date_from_url(valedictory_statement_url) : nil
  end

  def in_parliament? parliament_id
    if parliament_id != self.parliament_id
      false
    elsif Parliament.dissolution_date(parliament_id)
      to_date >= Parliament.dissolution_date(parliament_id)
    else
      true
    end
  end

  def is_active_on date
    if from_date == nil
      false
    elsif to_date
      date >= from_date && date <= to_date
    else
      date >= from_date
    end
  end

  private
  def date_from_url url
    Date.parse url[/\d\d\d\d\/\S\S\S\/\d\d/]
  end
end
