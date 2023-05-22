# frozen_string_literal: true

FactoryBot.define do
  factory :geolocation do
    geohash { GeoHash.encode(Faker::Address.latitude, Faker::Address.latitude) }
  end

end