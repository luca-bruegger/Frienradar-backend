# frozen_string_literal: true

class InvitationSerializer < ApplicationSerializer
  attributes :id, :created_at

  attribute :sender_username do |object|
    User.find(object.user_id).username
  end

  attribute :friend_username do |object|
    User.find(object.friend_id).username
  end

  attribute :friend_guid do |object|
    User.find(object.friend_id).guid
  end

  attribute :sender_guid do |object|
    User.find(object.user_id).guid
  end

  attribute :sender_profile_picture do |object|
    User.find(object.user_id).profile_picture.url
  end
end