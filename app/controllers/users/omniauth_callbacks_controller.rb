class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    binding.pry
    @user = User.from_omniauth(request.env["omniauth.auth"])
    self.resource = warden.authenticate!(@user)
    sign_in(resource_name, resource)
    render json: {success: true, jwt: current_token, response: "Authentication successful" }
    
  end
  private
  def current_token
    request.env['warden-jwt_auth.token']
  end
end

