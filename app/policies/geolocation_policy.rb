# frozen_string_literal: true

class GeolocationPolicy < ApplicationPolicy

  def initialize(user, geolocation)
    @user = user
    @geolocation = geolocation
  end

  def update?
    @user.geolocation_id == @geolocation.id
  end
end