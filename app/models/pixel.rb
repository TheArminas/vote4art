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

  validates :color, length: { in: 12..17 }
  validates :x, length: { in: 0..1000 }
  validates :y, length: { in: 0..1000 }

  scope :ready, lambda {
    select('distinct on(x, y) x, y, color, user_id')
      .order(:x)
  }

  scope :init_ready, lambda {
    select('distinct on(x, y) x, y, color, user_id')
      .order(:x)
  }

  scope :by_coordinates, ->(params) { where('pixels.x = ? AND pixels.y = ?', params[:x], params[:y]) }

  enum status: %i[init ready]

  after_commit :check_count

  private

  def check_count
    if Pixel.where(status: 0).count >= 400
      Pixel.update_all(status: 1)
    end
  end
end
