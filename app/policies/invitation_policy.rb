# frozen_string_literal: true

class InvitationPolicy < ApplicationPolicy
  def initialize(current_user, model)
    @current_user = current_user
    @invitation = model
  end

  def index?
    @current_user.present?
  end

  def create?
    !@current_user.friends.include?(@invitation.friend_id) &&
      !@current_user.invitations.pluck(:friend_id).include?(@invitation.friend_id)
  end

  def destroy?
    @current_user.id == @invitation.user_id || @current_user.id == @invitation.friend_id
  end

  def accept?
    @current_user.id == @invitation.friend_id
  end
end