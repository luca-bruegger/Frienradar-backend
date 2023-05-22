# frozen_string_literal: true

class SocialAccountSerializer < ApplicationSerializer
  attributes :id, :provider, :username

  attribute :provider_key do |object|
    object.class.providers[object.provider]
  end
end
