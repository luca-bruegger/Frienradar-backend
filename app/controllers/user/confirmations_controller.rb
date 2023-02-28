# frozen_string_literal: true

class User::ConfirmationsController < Devise::ConfirmationsController
  include ActionController::Helpers

  helper_method :deeplink_path

  def new
    if current_user.confirmed?
      render json: {
        status: { code: 200 },
        message: "Your account is already confirmed."
      }, status: :ok
    else
      current_user.send_confirmation_instructions
      render json: {
        status: { code: 200 },
        message: "Successfully sent confirmation instructions."
      }, status: :ok
    end
  end

  private

  def deeplink_path(token)
    `https://app.frienradar.com/additional-login-data?token=#{token}`
  end

end