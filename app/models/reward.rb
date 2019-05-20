class Reward < ApplicationRecord
  has_many :rewarded_users
  has_many :users, through: :rewarded_users

  HASH = ['9282c043', 'b357906c', 'bdb4defa'].freeze

  class << self
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
