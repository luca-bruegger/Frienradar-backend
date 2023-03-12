class CurrentUserController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    if current_user.nil?
      render json: {
        status: { code: 401 },
        data: nil
      }, status: :unauthorized
    else
      render json: {
        status: { code: 200 },
        data: CurrentUserSerializer.new(current_user).serializable_hash[:data][:attributes]
      }, status: :ok
    end
  end

end
