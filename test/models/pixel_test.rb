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

require 'test_helper'

class PixelTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
