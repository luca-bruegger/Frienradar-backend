# frozen_string_literal: true

class GeolocationSerializer
  include JSONAPI::Serializer

  attributes :id, :geohash
end