# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    render json: {
      error: {
        message: "You are not authorized to perform this action."

      }
    }, status: :forbidden
  end

  def not_found
    render plain: "Not found. But server is working :)", status: 404
  end

end
