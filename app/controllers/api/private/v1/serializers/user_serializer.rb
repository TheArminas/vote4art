module Api
  module Private
    module V1
      module Serializers
        class UserSerializer
          include FastJsonapi::ObjectSerializer

          attributes :username

          meta do |user|
            {
              status: user.terms_and_conditions ? :success : :error,
              active_pixels: user.available_pixel
            }
          end
        end
      end
    end
  end
end

