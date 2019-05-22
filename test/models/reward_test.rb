# == Schema Information
#
# Table name: rewards
#
#  id         :bigint           not null, primary key
#  lat        :string
#  long       :string
#  hashie     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tipas      :string
#  valid_till :datetime
#  value      :integer
#

require 'test_helper'

class RewardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
