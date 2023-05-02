# frozen_string_literal: true

require_relative 'helpers/geohash_generator'

class GeolocationSeeds
  def self.generate
    User.all.each_with_index do |user, index|
      index % 10 == 0 ? puts('Seeding geohash @' + index.to_s) : nil
      user.geolocation.geohash = geohash(index)
      user.geolocation.save!
    end
  end

  def self.geohash(index)
    case index
    when 1..5
      "u0m3tz"
    when 6..10
      "u0m3" + GeohashGenerator.generate(geohash_length: 2)
    when 11..15
      "u0" + GeohashGenerator.generate(geohash_length: 4)
    when 16..20
      "u" + GeohashGenerator.generate(geohash_length: 5)
    else
      GeohashGenerator.generate(geohash_length: 6)
    end
  end
end