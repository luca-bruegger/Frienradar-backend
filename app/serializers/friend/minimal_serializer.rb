# frozen_string_literal: true

class Friend::MinimalSerializer < ApplicationSerializer
  attributes :id, :username

  attribute :profile_picture do |object|
    object.profile_picture.url
  end
end