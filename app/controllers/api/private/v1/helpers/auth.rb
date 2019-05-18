module Api
  module Private
    module V1
      module Helpers
        module Auth
          def authorize
            http_auth_header
          end
          
          private

          def decoded_auth_token
            @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
          end

          def http_auth_header
            if headers['Authorization'].present?
              return headers['Authorization'].split(' ').last
            else
              error!(msg: "Autorizacija privaloma", status: 401)
            end
          end

          def current_user
            @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
          end
        end
      end
    end
  end
end
