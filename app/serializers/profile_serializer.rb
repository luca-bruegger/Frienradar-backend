# frozen_string_literal: true

class ProfileSerializer < ApplicationSerializer
  attributes :id, :name, :username, :description, :updated_at

  attribute :profile_picture do |object|
    object.profile_picture.url
  end

  attribute :email do |object|
    object.email || object.unconfirmed_email
  end

  attribute :invitation_count do |object|
    object.invitations.count
  end

  attribute :invitation do |object, params|
    current_user = params[:current_user]
    sender = Invitation.where(user_id: current_user.id, friend_id: object.id, confirmed: true)
    receiver = Invitation.where(user_id: object.id, friend_id: current_user.id, confirmed: true)
    invitation = sender + receiver
    ::Invitation::MinimalSerializer.new(invitation.first).serializable_hash[:data][:attributes]
  end

  attribute :social_accounts do |object|
    object.social_accounts.map do |social_account|
      ::SocialAccount::MinimalSerializer.new(social_account).serializable_hash[:data][:attributes]
    end
  end
end