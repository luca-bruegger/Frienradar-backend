# frozen_string_literal: true

require_relative 'helpers/geohash_generator'

class GeolocationSeeds
  def self.generate
    User.all.each_with_index do |user, index|
      hsh = geohash(index)
      puts "Seeding geolocation @#{index} with geohash #{hsh}"
      user.geolocation.geohash = hsh
      user.geolocation.save!
    end
  end

  def self.geohash(index)
    case index
    when 1..10
      "u0m3tz"
    when 11..20
      "u0m3" + GeohashGenerator.generate(geohash_length: 2)
    when 21..30
      "u0" + GeohashGenerator.generate(geohash_length: 4)
    when 31..40
      "u" + GeohashGenerator.generate(geohash_length: 5)
    else
      GeohashGenerator.generate(geohash_length: 6)
    end
  end
end