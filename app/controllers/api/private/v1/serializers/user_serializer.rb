module Api
  module Private
    module V1
      module Serializers
        class UserSerializer
          include FastJsonapi::ObjectSerializer

          attributes :username

          meta do |user|
            {
              active: user.terms_and_conditions,
              status: user.terms_and_conditions ? :success : :error
            }
          end
        end
      end
    end
  end
end

