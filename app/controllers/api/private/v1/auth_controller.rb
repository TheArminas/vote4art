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
          s = request.env['HTTP_USER_AGENT']&.to_s&.concat(request.env['HTTP_X_FORWARDED_FOR'] ||="wmsecret") 
          current_jwt = JsonWebToken.encode({ user_id: resource.id }, s)
          # return if JwtBlacklist.find_by(jti: current_jwt)
          if sign_in(resource_name, resource)
            response.headers['Authorization'] = current_jwt
            render json: { 
              status: (resource.terms_and_conditions ? 'success' : 'error')
            }
          end
        end

        def fb
          s = 'break';
          if params[:uid].present?
            s = request.env['HTTP_USER_AGENT']&.to_s&.concat(request.env['HTTP_X_FORWARDED_FOR'] ||="wmsecret") 
            user = User.find_or_create_with_facebook_uid(params)
          end
          if user
            current_jwt = JsonWebToken.encode({ user_id: user.id }, s)

            response.headers['Authorization'] = current_jwt
            render json: { 
              status: (user.terms_and_conditions ? 'success' : 'error'),
              new_user: user.created_at > ( Time.now - 10.minutes )
            }
          else
            render json: { message: 'Facebook prisijungimas nepavyko' }, status: 401
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
