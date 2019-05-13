class RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token # skip CSRF check for APIs
  before_action :rewrite_param_names, only: [:create]

  def create
    user = User.create(permitted_params)
    if user.persisted?
      UserSerializer.new(user).serialized_json
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
