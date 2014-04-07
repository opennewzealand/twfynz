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

class VotePlaceholder < Contribution

  before_destroy :destroy_vote
  belongs_to :vote, :include => {:vote_casts => :party}

  alias_method :original_is_vote?, :is_vote?
  alias_method :original_populate_spoken_by_id, :populate_spoken_by_id

  def bill
    bill = debate.bill
    if !bill && debate.is_a?(SubDebate)
      bill = debate.formerly_about_bill
    end
    bill
  end

  def prefixed_anchor
    if debate.votes.size == 1
      anchor_prefix
    else
      super
    end
  end

  def anchor_prefix
    if vote
      if vote.is_a?(PartyVote)
        'party_vote'
      elsif vote.is_a?(PersonalVote)
        'personal_vote'
      else
        nil
      end
    else
      nil
    end
  end

  def is_vote?
    true
  end

  def debate
    spoken_in
  end

  protected

    def populate_spoken_by_id
      # do nothing, as vote placeholder has no speaker
    end

    def destroy_vote
      if vote
        vote.destroy
      end
    end

end
