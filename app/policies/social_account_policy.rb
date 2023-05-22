# frozen_string_literal: true

class SocialAccountPolicy < ApplicationPolicy
  def initialize(current_user, social_account)
    @current_user = current_user
    @social_account = social_account
  end

  def index?
    @current_user.present?
  end

  def create?
    @current_user.present?
  end

  def show?
    @current_user.present? && @current_user == @social_account.user
  end

  def update?
    @current_user.present? && @current_user == @social_account.user
  end

  def destroy?
    @current_user.present? && @current_user == @social_account.user && @current_user.social_accounts.count > 1
  end
end