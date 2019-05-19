class Reward < ApplicationRecord
  has_many :rewarded_users
  has_many :users, through: :rewarded_users

  HASH = %w[hash hash1 hash2].freeze

  class << self
    def confirm(params, c_user)
      return 'eik namo' if c_user.rewards.pluck(:hashie).include? params[:hash]
      if HASH.include? params[:hash]
        Confirmator.new(params, c_user)
      else
        'eik namo'
      end
    end
  end
end
