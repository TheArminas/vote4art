module Api
  module Private
    module V1
      module Serializers
        class UserSerializer
          include FastJsonapi::ObjectSerializer

          attributes :username, :user_rewards
          attribute :a_pixels do |object|
            object.available_pixel + object.user_rewards
          end
          meta do |user|
            {
              status: user.terms_and_conditions ? :success : :error,
              photo: Photo.last
            }
          end
        end
      end
    end
  end
end

