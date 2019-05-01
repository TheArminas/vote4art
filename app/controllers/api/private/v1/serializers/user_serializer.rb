module Api
  module Private
    module V1
      module Serializers
        class UserSerializer
          include FastJsonapi::ObjectSerializer

          attributes :username
        end
      end
    end
  end
end

