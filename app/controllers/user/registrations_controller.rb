# frozen_string_literal: true

class User::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def create_geolocation
    Geolocation.create!(
      user: resource
    )
  end

  def respond_with(resource, _opts = {})
    if resource.persisted?
      create_geolocation
      render json: {
        message: 'Signed up sucessfully.',
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
      }, status: :created
    else
      render json: "User couldn't be created. #{resource.errors.full_messages.to_sentence}",
             status: :unprocessable_entity
    end
  end

  def sign_up_params
    params.permit(:email, :password, :name, :profile_picture)
  end

end