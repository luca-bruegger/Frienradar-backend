# frozen_string_literal: true

class UserSerializer < ApplicationSerializer
  attributes :id, :name, :username, :description, :preferred_distance, :updated_at

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
    object.geolocation.present? ? object.geolocation.id : nil
  end

  attribute :invitation_count do |object|
    object.invitations.count
  end
end
