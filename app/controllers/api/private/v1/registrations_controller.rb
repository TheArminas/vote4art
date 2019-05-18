module Api
  module Private
    module V1
      class RegistrationsController < Devise::RegistrationsController
        skip_before_action :verify_authenticity_token # skip CSRF check for APIs
        before_action :rewrite_param_names, only: [:create]

        def create
          user = User.create(permitted_params)
          if user.persisted?
            current_jwt = JsonWebToken.encode(user_id: user.id)
            response.headers["Authorization"] = current_jwt
            render json: { 
              status: 'Authenticated',
              response: { 
                user: {
                  active: user.terms_and_conditions,
                },
              }
            }
          else
            render json: { error: user.errors }
          end
        end

        private

        def permitted_params
          params.require(:user).permit(:username, :password, :password_confirmation, :terms_and_conditions)
        end

        def rewrite_param_names
          request.params[:user] = { username: request.params[:username], password: request.params[:password] }
        end
      end
    end
  end
end

