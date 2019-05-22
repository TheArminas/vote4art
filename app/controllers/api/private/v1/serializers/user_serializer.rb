module Api
  module Private
    module V1
      module Serializers
        class UserSerializer
          include FastJsonapi::ObjectSerializer

          attributes :username

          attribute :pixels do |object|
            object.available_pixel
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

