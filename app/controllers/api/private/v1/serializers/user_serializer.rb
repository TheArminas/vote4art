module Api
  module Private
    module V1
      module Serializers
        class UserSerializer
          include FastJsonapi::ObjectSerializer

          attributes :username, :provider

          meta do |user|
            {
              active: user.terms_and_conditions,
              status: user.terms_and_conditions ? :success : :error,
              photo: Photo.last,
              active_pixels: user.available_pixel - user.pixels_today
            }
          end
        end
      end
    end
  end
end

