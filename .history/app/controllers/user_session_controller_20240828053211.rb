class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    resource = warden.authenticate!(auth_options)
    if resource
      sign_in(resource_name, resource)
      render json: { token: current_token }, status: :ok
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  private

  def current_token
    request.env['warden-jwt_auth.token']
  end
end
