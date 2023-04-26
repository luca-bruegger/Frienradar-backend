# frozen_string_literal: true

class UserSerializer < ApplicationSerializer
  attributes :guid, :email, :name, :confirmed, :username, :email, :preferred_distance

  attribute :confirmed do |object|
    object.confirmed?
  end

  attribute :profile_picture do |object|
    object.profile_picture.url
  end

  attribute :email do |object|
    object.email || object.unconfirmed_email
  end

  attribute :geolocation_id do |object|
    object.geolocation.id
  end

  attribute :invitation_count do |object|
    object.invitations.count
  end
end
