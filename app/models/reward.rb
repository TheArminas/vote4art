class Reward < ApplicationRecord
  has_many :rewarded_users
  has_many :users, through: :rewarded_users

  HASH = %w['9282c043', 'b357906c', 'bdb4defa'].freeze

  class << self
    def confirm(params, c_user)
      return false  if c_user.rewards.pluck(:hashie).include? params[:hash]
      if HASH.include? params[:hash]
        Confirmator.new(params, c_user)
      else
        false
      end
    end
  end
end
