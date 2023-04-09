# frozen_string_literal: true

class GeolocationsController < CrudController
  before_action :authenticate_user!, only: [:update]

  # def update
  #   if current_user.geolocation_id == geolocation.id && geolocation.update(geolocation_params)
  #     render json: {
  #       data: GeolocationSerializer.new(geolocation).serializable_hash[:data][:attributes]
  #     }, status: :ok
  #   else
  #     render json: {
  #       message: geolocation.errors.full_messages.to_sentence
  #     }, status: :unprocessable_entity
  #   end
  # end

  private

  def permitted_attrs
    [:geohash]
  end
end
