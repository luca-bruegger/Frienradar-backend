# frozen_string_literal: true

class User::PasswordsController < Devise::PasswordsController
  respond_to :json

  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    render json: {
      data: 'Password email sent if email address exists.'
    }, status: :ok
  end

  private

  def respond_with(resource, _opts = {})
    render json: {
      message: 'Logged in sucessfully.',
      data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
    }, status: :ok
  end

end