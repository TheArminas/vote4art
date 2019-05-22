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
#  pixels_today           :integer          default(0)
#  total_pixels           :integer          default(0)
#  terms_and_conditions   :boolean          default(FALSE)
#  user_rewards           :integer          default(0)
#  pix_rew                :integer          default(0)
#


require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
