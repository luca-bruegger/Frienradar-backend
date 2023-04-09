# frozen_string_literal: true

class UserSerializer
  include JSONAPI::Serializer

  attributes :id, :guid, :email, :name, :confirmed, :username, :email, :preffered_distance, :geolocation_id

  attribute :confirmed do |object|
    object.confirmed?
  end

  attribute :profile_picture do |object|
    object.profile_picture.url
  end

  attribute :email do |object|
    object.email || object.unconfirmed_email
  end

  attribute :geolocation do |object|
    object.geolocation.id
  end
end
