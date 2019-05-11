# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token # skip CSRF check for APIs

  prepend_before_action :require_no_authentication, only: [:create] # skip device auth check
  #prepend_before_action :allow_params_authentication!, only: :create  # Not needed afterall?

  before_action :rewrite_param_names, only: [:create]

  # new() method is the default method to call if Devise fails to authenticate user
  def new
    render json: {msg: "Authentication required"}, status: 401
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    yield resource if block_given?
    render json: {success: true, jwt: current_token, response: "Authentication successful" }
  end
  def destroy
  end
  private
  

  # warden uses request.params values when doinh authentication.
  # Lets rewrite params from json to correct format for warden.
  def rewrite_param_names
    request.params[:user] = {username: request.params[:username], password: request.params[:password]}
  end

end
