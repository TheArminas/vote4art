<<<<<<< HEAD
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
<<<<<<< HEAD
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
=======
#  id         :bigint           not null, primary key
#  username   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  jti        :string
>>>>>>> 2296d8beea0ff26db0186cdd4d228430db87a4d8
#

=======
>>>>>>> pixel
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
