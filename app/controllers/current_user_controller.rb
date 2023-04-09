# frozen_string_literal: true

class CurrentUserController < ApplicationController
  before_action :authenticate_user!, only: [:index, :update]

  def index
    if current_user.nil?
      render json: {
        data: nil
      }, status: :unauthorized
    else
      render json: {
        data: CurrentUserSerializer.new(current_user).serializable_hash[:data][:attributes]
      }, status: :ok
    end
  end

  def update
    if current_user.update(user_params)
      render json: {
        data: CurrentUserSerializer.new(current_user).serializable_hash[:data][:attributes]
      }, status: :ok
    else
      render json: {
        message: current_user.errors.full_messages.to_sentence
      }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_picture, :username, :preffered_distance)
  end

end
