# == Schema Information
#
# Table name: rewarded_pixels
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  count      :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class RewardedPixelTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
