module Api
  module Private
    module V1
      class RegistrationsController < Devise::RegistrationsController
        skip_before_action :verify_authenticity_token # skip CSRF check for APIs
        before_action :rewrite_param_names, only: [:create]

        def create
          s = 'break'
          
          exist = User.find_by(uniid: permitted_params['uniid'])
          return render json: { error: "Nesilaikantys taisyklių dalyviai bus šaliniami." }, status: 401  if exist.present?
          user = User.create(permitted_params)  if exist.blank?
         
          if user.present?
            s = request.env['HTTP_USER_AGENT']&.to_s&.concat(request.env['HTTP_X_FORWARDED_FOR'] ||"wmsecret") 

            current_jwt = JsonWebToken.encode({ user_id: user.id }, s)
            response.headers["Authorization"] = current_jwt
            render json: {
              status: (user.terms_and_conditions ? 'success' : 'error'),
              success: "Sveikiname sėkmingai užsiregistravus",
              error: "Turite sutikti su taisyklėmis"
            } 
          else
            render json: { error: user.errors }, status: 401
          end
        end

        private

        def permitted_params
          params.require(:user).permit(:username, :password, :password_confirmation, :terms_and_conditions, :uniid)
        end

        def rewrite_param_names
          ip = request.remote_ip || 'testas'
          request.params[:user] = {
            username: request.params[:username],
            password: request.params[:password],
            password_confirmation: request.params[:password_confirmation], 
            terms_and_conditions: request.params[:terms_and_conditions], 
            uniid: "#{ip}-#{request.params[:finger]}"
          }
        end
      end
    end
  end
end

