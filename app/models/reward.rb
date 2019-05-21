class Reward < ApplicationRecord
  has_many :rewarded_users
  has_many :users, through: :rewarded_users

  HASH = ['9282c043', 'b357906c', 'bdb4defa'].freeze

  class << self
    def add_to_user(options = {})
      hash = options[:hash]
      user = options[:user]

      rew = where('valid_till >= ?', Time.now).find_by(hashie: hash)
      if rew
        return false if rew.user_ids.include? user.id
        rew.users << user
        value = rew.value
        user.increment(:rewards, value)
        user.save
      else
        false
      end
    end

    def confirm(params, c_user)
      user = User.find(c_user)
      return false  if user.rewards.pluck(:hashie).include? params[:hash]
      if HASH.include? params[:hash]
        Confirmator.new(params, user).connect
      else
        false
      end
    end
  end
end
