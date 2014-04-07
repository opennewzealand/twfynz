# == Schema Information
#
# Table name: donations
#
#  id              :integer          not null, primary key
#  party_name      :string(255)
#  party_id        :integer
#  donor_name      :string(255)
#  organisation_id :integer
#  donor_address   :string(255)
#  amount          :integer
#  year            :integer
#  created_at      :datetime
#  updated_at      :datetime
#

require 'spec_helper'

describe Donation do

  assert_model_belongs_to :party
  assert_model_belongs_to :organisation

end
