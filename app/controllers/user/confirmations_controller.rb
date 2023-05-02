# frozen_string_literal: true

class User::ConfirmationsController < Devise::ConfirmationsController
  respond_to :json

  def create
    self.resource = resource_class.send_confirmation_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      render json: {
        data: 'Verification email sent.'
      }, status: :ok
    else
      render json: {
        data: 'Verification email could not be sent.'
      }, status: :unprocessable_entity
    end
  end

  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      set_flash_message!(:notice, :confirmed)
      render json: {
        data: 'Your email address has been successfully confirmed.'
      }, status: :ok
    else
      render json: {
        data: resource.errors.full_messages
      }, status: :unprocessable_entity
    end
  end
end