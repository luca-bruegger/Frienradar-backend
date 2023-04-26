# frozen_string_literal: true

class NearbyUsersController < CrudController
  before_action :authenticate_user!
  GEOHASH_LENGTS = [6, 4, 3, 2].freeze

  def index
    super(options)
  end

  private

  def nearby_user_ids
    geolocations = Geolocation.where("geohash LIKE :geohash", geohash: "#{geohash}%")
    geolocations.pluck(:user_id) - [current_user.id]
  end

  def fetch_entries
    User.where(id: nearby_user_ids).paginate(page: page).to_a
  end

  def model_class
    :nearby_user
  end

  def model_scope
    User
  end

  def model_serializer
    NearbyUserSerializer
  end

  def geohash
    current_user.geolocation.geohash.first(distance)
  end

  def distance
    GEOHASH_LENGTS[params[:distance].to_i || current_user.preferred_distance]
  end

  def options
    options = {}
    options[:meta] = {
      total: nearby_user_ids.count,
      preferred_distance: current_user.preferred_distance
    }
    options[:is_collection] = true

    options
  end
end