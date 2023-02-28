# frozen_string_literal: true

class UserSerializer
  include JSONAPI::Serializer
  attributes :guid, :email, :name, :confirmed

  attribute :confirmed do |object|
    object.confirmed?
  end

  attribute :profile_picture do |object|
    object.profile_picture.url
    end
end
