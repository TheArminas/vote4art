module Api
  module Private
    module V1
      module Helpers
        module Auth
          def authorize
            current_user
          end
          
          private

          def decoded_auth_token
            @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
          end

          def http_auth_header
            if headers['Authorization'].present?
              return headers['Authorization'].split(' ').last
            else
              present json: { msg: 'Authentication required' }, status: 401
            end
            nil
          end

          def current_user
            @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
          end
        end
      end
    end
  end
end
