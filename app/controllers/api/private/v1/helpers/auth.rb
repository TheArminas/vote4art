module Api
  module Private
    module V1
      module Helpers
        module Auth
          def authorize
            http_auth_header
          end
          def current_user
            @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
          end
          
          private

          def decoded_auth_token
            # decode bus dynaminis pagal ip ir browseri encode()
            @decoded_auth_token ||= JsonWebToken.decode(http_auth_header, dynamic_secret)
            logger.info("User-input: #{@decoded_auth_token&.symbolize_keys}")

            @decoded_auth_token&.symbolize_keys
          end

          def dynamic_secret
            return request.env['HTTP_USER_AGENT']&.to_s&.concat(request.env['HTTP_X_FORWARDED_FOR'] ||="wmsecret") 

          end

          def http_auth_header
            if headers['Authorization'].present?
              # tikrinti bariera
              return headers['Authorization'].split(' ').last
            else
              error!(msg: "Autorizacija privaloma", status: 401)
            end
          end


        end
      end
    end
  end
end
