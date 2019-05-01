class Pixel < ApplicationRecord
  belongs_to :user

  scope :ready, lambda {
    select('distinct on(x, y) x, y, color, user_id')
      .order(:x)
  }
  scope :by_coordinates, ->(params) { where('pixels.x = ? AND pixels.y = ?', params[:x], params[:y]) }

  enum status: %i[init ready]

  after_commit :check_count

  private

  def check_count
    if Pixel.where(status: 0).count >= 500
      Pixel.update_all(status: 1)
    end
  end
end
