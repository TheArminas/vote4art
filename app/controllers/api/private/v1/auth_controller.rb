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
          c_token = JsonWebToken.encode(user_id: resource.id)
          sign_in(resource_name, resource)
          render json: { success: true, jwt: c_token, response: 'Authentication successful' }
        end

        def fb
          facebook_access_token = params.require(:facebook_access_token) if params[:facebook_access_token].present?
          user = User.find_or_create_with_facebook_access_token(facebook_access_token)

          if user && user.persisted?
            c_token = JsonWebToken.encode(user_id: user.id)
            render json: { success: true, jwt: c_token, response: {user: user} }
            
          else
            render json: { response: 'Facebook access token missing' }
          end
        end
        
        def destroy; end
        private
        def rewrite_param_names
          request.params[:user] = {username: request.params[:username], password: request.params[:password]}
        end
      end
    end
  end
end
