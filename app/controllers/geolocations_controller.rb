# frozen_string_literal: true

class GeolocationsController < CrudController
  before_action :authenticate_user!, only: [:update]

  private

  def permitted_attrs
    [:geohash]
  end
end
