# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pundit::Authorization
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    render json: {
      error: {
        message: "You are not authorized to perform this action."

      }
    }, status: :not_allowed
  end

  def not_found
    render plain: "Not found.", status: 404
  end

end
