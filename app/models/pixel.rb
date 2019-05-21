# == Schema Information
#
# Table name: pixels
#
#  id         :bigint           not null, primary key
#  color      :string
#  user_id    :bigint           not null
#  x          :string
#  y          :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :integer          default("init")
#

class Pixel < ApplicationRecord
  belongs_to :user

  validates :color, length: { in: 12..18 }
  validates :x, length: { in: 0..1000 }
  validates :y, length: { in: 0..1000 }

  scope :ready, lambda {
    where(status: [0, 1])
      .select(:x, :y, :color)
      .group(:x, :y, :color)
      .order('MAX(id) DESC')
  }

  scope :init_ready, lambda {
    where(status: 0)
      .select(:x, :y, :color)
      .group(:x, :y, :color)
      .order('MAX(id) DESC')
  }

  scope :by_coordinates, ->(params) { where('pixels.x = ? AND pixels.y = ?', params[:x], params[:y]) }

  enum status: %i[init ready, safe]

  after_commit :check_count
  after_create :set_increment_pix

  private

  def set_increment_pix
    if user.available_pixel.to_i > 0
      user.increment!(:pixels_today)
      user.increment!(:total_pixels)
      user.save
    elsif user.user_rewards.to_i > 0
      user.decrement!(:user_rewards)
      user.increment!(:total_pixels)
      user.save
    end
  end

  def check_count
    if Pixel.where(status: 0).count >= 250
      resp = Generators::Photo.new(pixels: Pixel.init_ready.pluck(:x, :y, :color)).connect
      if resp
        Pixel.where(status: 1).update_all(status: 2)
        Pixel.where(status: 0).update_all(status: 1)
      end 
    end
  end
end
