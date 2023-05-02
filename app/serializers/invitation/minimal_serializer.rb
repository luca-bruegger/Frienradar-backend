# frozen_string_literal: true

class Invitation::MinimalSerializer < ApplicationSerializer
  attributes :id, :updated_at

  attribute :sender_id do |object|
    object.user_id
  end

  attribute :receiver_id do |object|
    object.friend_id
  end
end