class CurrentUserController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: {
      status: { code: 200 },
      data: CurrentUserSerializer.new(current_user).serializable_hash[:data][:attributes]
    }
  end
end
