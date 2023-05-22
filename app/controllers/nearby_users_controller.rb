# frozen_string_literal: true

class NearbyUsersController < CrudController
  before_action :authenticate_user!
  GEOHASH_LENGTHS = [6, 4, 3, 2, 0].freeze

  def index
    super(options)
  end

  private

  def nearby_user_ids
    case distance
    when 6
      geolocations = Geolocation.where("geohash LIKE :geohash", geohash: "#{geohash_by_distance}%")
    when 4
      geolocations = Geolocation.where("geohash LIKE :geohash", geohash: "#{geohash_by_distance}%")
                       .where.not("geohash LIKE :geohash", geohash: "#{geohash.first(GEOHASH_LENGTHS[0])}%")
    when 3
      geolocations = Geolocation.where("geohash LIKE :geohash", geohash: "#{geohash_by_distance}%")
                       .where.not("geohash LIKE :geohash", geohash: "#{geohash.first(GEOHASH_LENGTHS[1])}%")
    when 2
      geolocations = Geolocation.where("geohash LIKE :geohash", geohash: "#{geohash_by_distance}%")
                       .where.not("geohash LIKE :geohash", geohash: "#{geohash.first(GEOHASH_LENGTHS[2])}%")
    else
      geolocations = Geolocation.where.not("geohash LIKE :geohash", geohash: "#{geohash.first(GEOHASH_LENGTHS[3])}%")
    end

    ids = geolocations.pluck(:user_id) - [current_user.id]
    ids.uniq
  end

  def fetch_entries
    User.registration_completed.where(id: nearby_user_ids).paginate(page: page).to_a
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

  def permitted_attrs
    [:geohash]
  end

  def geohash_by_distance
    geohash.first(distance)
  end

  def geohash
    params[:geohash] || current_user.geolocation.geohash
  end

  def distance
    GEOHASH_LENGTHS[params[:distance].to_i || current_user.preferred_distance]
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