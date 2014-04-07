# encoding: UTF-8
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

class PartyVote < Vote

  after_save :expire_cached_pages

  include ExpireCache

  def expire_cached_pages
    return unless is_file_cache?

    uncache "/parliaments/#{Parliament.latest}.cache"
    uncache "/parties/third_reading_and_negatived_votes.cache"
    uncache "/parties/third_reading_and_negatived_votes.csv.cache"

    list = Party.party_list
    list.each do |party|
      (list - [party]).each do |other_party|
        uncache "/parties/#{party.id_name}/#{other_party.id_name}.cache"
      end
    end
  end
end
