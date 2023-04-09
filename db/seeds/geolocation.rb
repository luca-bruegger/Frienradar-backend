# frozen_string_literal: true

class GeolocationSeeds
  def self.generate
    3.times do |index|
      new.generate(index)
    end
  end

  def generate(index)
    user = User.find(index + 1)
    Geolocation.create!(
      geohash: GeoHash.encode(::Faker::Address.latitude, ::Faker::Address.longitude, 6),
      user: user,
      guid: user.guid
    )
  end
end