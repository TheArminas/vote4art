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

  validates :username, presence: true
  validates :password, presence: true
  validates :username, uniqueness: true
  validates :uid, uniqueness: true, allow_blank: true
  has_many :pixels
  has_many :rewarded_users
  has_many :rewards, through: :rewarded_users
  has_many :rewarded_pixels

  def self.find_or_create_with_facebook_uid(params)
    return unless params[:uid]

    user = User.find_or_create_by(uid: params[:uid]) do |user|
      return user unless user.new_record?
      user.username = params[:name]
      user.uid = params[:uid]
      user.provider = 'facebook'
      user.password = params[:uid]
      user.save
    end
    user
  end

  def email_required?
    false
  end

  def available_pixel
    pixto = user.pixels_today
    total_time = 86400;
    pixel_in_day = 24;
    pixel = total_time / pixel_in_day
    t1 = ((Time.now).beginning_of_day).to_i
    t2 = (Time.now).to_i
    ((((t2 - t1))) / pixel + 1) - pixto#  pridedam atimti count sosdienos jai atsukam valanda t1 tada dadedam p;
  end

  def jwt_payload
    super.merge('test' => 'Ok')
  end
end
