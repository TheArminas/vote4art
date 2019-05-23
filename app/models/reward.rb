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

class Reward < ApplicationRecord
  has_many :rewarded_users
  has_many :users, through: :rewarded_users

  HASH = ['9282c043', 'b357906c', 'bdb4defa', 'bdb4dfff'].freeze

  TIPAI = ['Isankstinis', 'Apylinkes'].freeze
  class << self
    def add_to_user(options = {})
      hash = options[:hash]
      user = options[:user]

      rew = where('valid_till >= ?', Time.now).find_by(hashie: hash)
      if rew
        return false if rew.user_ids.include? user.id
        rew.users << user
        value = rew.value
        user.increment(:pix_rew, value)
        user.save
      else
        false
      end
    end

    def confirm(params, c_user)
      return 1 if HASH.exclude?(params[:hash])
      user = User.find(c_user)
      rewarr = user.rewards.pluck(:tipas)
      if rewarr.exclude?(TIPAI[0]) && rewarr.exclude?(TIPAI[1])
       user = Confirmator.new(params, user).connect
       false unless user.present?
      else
        1
      end
    end
  end
end
