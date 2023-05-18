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

  # PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      if resource_class.sign_in_after_reset_password
        resource.after_database_authentication
        sign_in(resource_name, resource)
      else
        respond_with_error
      end
      respond_with_error(resource.errors)
    else
      set_minimum_password_length
      respond_with resource
    end
  end

  private

  def respond_with(resource, _opts = {})
    render json: {
      status: {code: 200, message: 'Logged in sucessfully.'},
      data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
    }, status: :ok
  end

  def respond_with_error(errors = [])
    render json: errors.full_messages.to_sentence, status: :bad_request
  end

end