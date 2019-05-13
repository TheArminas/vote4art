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
#  jti                    :string
#  provider               :string
#  uid                    :string
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable

  has_many :pixels

  def self.find_or_create_with_facebook_access_token(oauth_access_token)
    return unless oauth_access_token
    graph = Koala::Facebook::API.new(oauth_access_token)
    profile = graph.get_object('me', fields: ['name', 'email'])

    data = {
      username: profile['name'],
      uid: profile['id'],
      provider: 'facebook',
      # oauth_token: oauth_access_token,
      password: SecureRandom.urlsafe_base64
    }

    if user = User.find_by(uid: data['uid'], provider: 'facebook')
      user.update_attributes(data)
    else
      User.create(data)
    end
  end

  def email_required?
    false
  end
end
