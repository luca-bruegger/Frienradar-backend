# frozen_string_literal: true

class ProfilePolicy < ApplicationPolicy

  def initialize(current_user, profile)
    @current_user = current_user
    @profile = profile
  end

  def show?
    @current_user.friends.include?(@profile)
  end
end