# frozen_string_literal: true

class CurrentUserController < CrudController
  before_action :authenticate_user!, only: [:show, :update, :update_with_profile_picture]

  def update_with_profile_picture(options = {})
    authorize entry
    entry.attributes = update_params
    if entry.save
      render_entry(options[:render_options])
    else
      render_errors
    end
  end

  private

  def permitted_attrs
    [:name, :description, :email, :profile_picture, :username, :preferred_distance]
  end

  def model_class
    User
  end

  def model_serializer
    CurrentUserSerializer
  end

  def fetch_entry
    model_scope.find(current_user.id)
  end

  def update_params
    params.permit(:name, :profile_picture, :username, :preferred_distance, :description)
  end
end
