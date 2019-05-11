class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    build_resource(sign_up_params)

    resource.save
    render_resource(resource)
  end

  private

  def respond_with(resource, _opts = {})
    render json: resource
  end

  def respond_to_on_destroy
    head :no_content
  end
end
