# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :jwt_authenticatable, :omniauthable,       
         jwt_revocation_strategy: JWTBlacklist,
         omniauth_providers: %i[facebook]

  def self.from_omniauth(auth)
    binding.pry
    user = where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.username = 'fb-login'
      user.provider = auth.provider
      user.uid = auth.uid
      user.password = Devise.friendly_token[0,20]
    end
    user
  end

  def email_required?
    false
  end
  def jwt_payload
    binding.pry
    super.merge('test' => 'Ok')
  end
  def on_jwt_dispatch(token, payload)
    binding.pry

  end
end
