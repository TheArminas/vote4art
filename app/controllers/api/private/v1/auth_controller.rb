module Api
  module Private
    module V1
      class AuthController < Devise::SessionsController
        skip_before_action :verify_authenticity_token
        prepend_before_action :require_no_authentication, only: [:create]
        before_action :rewrite_param_names, only: [:create]

        def new
          render json: { msg: 'Authentication required' }, status: 401
        end

        def create
          self.resource = warden.authenticate!(auth_options)
          current_jwt = JsonWebToken.encode(user_id: resource.id)
          # return if JwtBlacklist.find_by(jti: current_jwt)
          if sign_in(resource_name, resource)
            response.headers["Authorization"] = current_jwt
            render json: { 
              status:  (resource.terms_and_conditions ? 'active' : 'authenticated')
            }
          end
        end

        def fb
          facebook_access_token = params.require(:facebook_access_token) if params[:facebook_access_token].present?
          user = User.find_or_create_with_facebook_access_token(facebook_access_token)

          if user
            current_jwt = JsonWebToken.encode(user_id: user.id)

            response.headers["Authorization"] = current_jwt
z            render json: { 
              status: (user.terms_and_conditions ? 'active' : 'authenticated')
            }
          else
            render json: { msg: 'Facebook access token missing' }, status: 401
          end
        end
        
        def destroy
          if headers['Authorization'].present?
            JwtBlackilist.create(jti: headers['Authorization'].split(' ').last)
            render json: { succes: true, msg: 'User logged out  successfully'}

          else
            render json: { msg: 'Missing authorization key' }
          end
        end

        private

        def rewrite_param_names
          request.params[:user] = {username: request.params[:username], password: request.params[:password]}
        end
      end
    end
  end
end
