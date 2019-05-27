module Api
  module Private
    module V1
      module Helpers
        module Auth
          def authorize
            # @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token && http_auth_header
            # if @user.present?
            #   uni_log
            # else
              error!(msg: "Autorizacija privaloma!!!", status: 401) 
            # end

          end

          def current_user
            @user
          end
          
          private

          def decoded_auth_token
            # decode bus dynaminis pagal ip ir browseri encode()
            @decoded_auth_token ||= JsonWebToken.decode(http_auth_header, dynamic_secret)

            @decoded_auth_token&.symbolize_keys
          end

          def dynamic_secret
            s = request.env['HTTP_USER_AGENT']&.to_s&.concat(request.env['HTTP_X_FORWARDED_FOR'] ||="wmsecret") 
          end

          def uni_log
              # dadeti prisijungimo laika 
            if headers['Finger'].present?
              @user
                .update_attribute(:uniid, "#{request.ip}-#{headers['Finger']}")
              else
                true
              end
            end

          def http_auth_header
            if headers['Authorization'].present?
              # tikrinti bariera !!! 
              return headers['Authorization'].split(' ').last
            else
              error!(msg: "Autorizacija privaloma!", status: 401)
            end
          end


        end
      end
    end
  end
end
