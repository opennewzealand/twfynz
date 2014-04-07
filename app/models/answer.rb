# encoding: UTF-8
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

class Answer < Contribution

  alias_method :original_is_answer?, :is_answer?

  def is_answer?
    true
  end

  def party_makes_sense? mp, date
    true
#    if mp.party
#      party = mp.party.short
#      if debate.about && debate.about.is_a?(Portfolio)
#        if Parliament.date_within?(48, date) && (party == 'National' || party == 'Green' || party == 'Maori Party' || party == 'ACT')
#          false
#        elsif Parliament.date_within?(49, date) && (party == 'Labour' || party == 'Green'  || party == 'Progressive')
#          false
#        else
#          true
#        end
#      else
#        true
#      end
#    else
#      true
#    end
  end

end
