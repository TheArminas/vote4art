# == Schema Information
#
# Table name: rewarded_users
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  reward_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class RewardedUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
