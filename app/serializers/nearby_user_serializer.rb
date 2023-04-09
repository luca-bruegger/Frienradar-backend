# frozen_string_literal: true

class NearbyUserSerializer < ApplicationSerializer
  attributes :guid, :username, :profile_picture

  attribute :profile_picture do |object|
    object.profile_picture.url
  end
end