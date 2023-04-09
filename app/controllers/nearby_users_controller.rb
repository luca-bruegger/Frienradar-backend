# frozen_string_literal: true

class NearbyUsersController < CrudController
  before_action :authenticate_user!

  def index
    options = {}
    options[:meta] = { total: nearby_user_ids.count }
    options[:is_collection] = true
    super(options)
  end

  private

  def nearby_user_ids
    geolocations = Geolocation.where("geohash LIKE :geohash", geohash: "#{current_user.geolocation.geohash}")
    geolocations.pluck(:user_id) - [current_user.id]
  end

  def fetch_entries
    User.where(id: nearby_user_ids).to_a
  end

  def model_class
    :nearby_user
  end

  def model_serializer
    NearbyUserSerializer
  end
end