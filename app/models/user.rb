class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :jwt_authenticatable,
         jwt_revocation_strategy: JWTBlacklist

  has_many :pixels

  def email_required?
    false
  end
end
