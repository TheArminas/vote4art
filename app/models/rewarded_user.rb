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

class RewardedUser < ApplicationRecord
  belongs_to :user
  belongs_to :reward
end
