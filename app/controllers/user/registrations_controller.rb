# frozen_string_literal: true

class User::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  after_action :create_geolocation, only: :create

  private

  def create_geolocation
    if resource.created?
      Geolocation.create!(
        user: resource,
        guid: resource.guid
      )
    end
  end

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        message: 'Signed up sucessfully.',
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
      }, status: :created
    else
      render json: {
        message: "User couldn't be created. #{resource.errors.full_messages.to_sentence}"
      }, status: :unprocessable_entity
    end
  end

  def sign_up_params
    params.permit(:email, :password, :name, :profile_picture)
  end

end