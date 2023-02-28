# frozen_string_literal: true

class ApplicationController < ActionController::API
  def ensure_confirmed
    unless current_user.confirmed?
      render json: {
        status: { code: 401 },
        message: "You need to confirm your account before continuing."
      }, status: :unauthorized
    end
  end

  def not_found
    render plain: "Not found.", status: 404
  end
end
