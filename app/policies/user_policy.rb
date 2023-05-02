# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def show?
    @user == @current_user
  end

  def update?
    @user == @current_user
  end

  def update_with_profile_picture?
    @user == @current_user
  end
end
