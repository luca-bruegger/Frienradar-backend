# frozen_string_literal: true

class NearbyUserPolicy < ApplicationPolicy
    def initialize(user, nearby_user)
      @user = user
      @nearby_user = nearby_user
    end

    def index?
      @user.geolocation.present?
    end

    def show?
      @user.geolocation.present?
    end
end