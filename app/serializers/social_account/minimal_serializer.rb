# frozen_string_literal: true

class SocialAccount::MinimalSerializer < ApplicationSerializer
  attributes :id, :username

  attribute :provider_key do |object|
    object.class.providers[object.provider]
  end
end