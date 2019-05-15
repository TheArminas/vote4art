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
  devise :database_authenticatable, :registerable, :jwt_authenticatable,
         jwt_revocation_strategy: JWTBlacklist

  has_many :pixels



  def email_required?
    false
  end

  def available_pixel
    totalTime = 86400; # atstumas tarp apdavonojimo
    pixel_in_day = 24; # apdovanojimu visame atsume
    pixel_count = totalTime / pixel_in_day # vienas tarpas
    time_start_at = (Date.today.to_time(:utc).to_i - 14400) # atimti sekundes utc iki pradzios  pvz: dabar 23H;
    time_now = Time.now.utc.to_i
    (time_now - time_start_at) / pixel_count  #  atimti dienos padetus pikselius
  end
  
  def jwt_payload
    super.merge('test' => 'Ok')
  end
  def on_jwt_dispatch(token, payload)
  end
end
