# frozen_string_literal: true

class RequestedUserPolicy < ApplicationPolicy
  def initialize(current_user, model)
    @current_user = current_user
    @model = model
  end

  def show?
    @current_user.present?
  end
end
