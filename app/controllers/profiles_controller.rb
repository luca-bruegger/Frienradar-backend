# frozen_string_literal: true

class ProfilesController < CrudController
  before_action :authenticate_user!

  def show
    authorize entry, policy_class: ProfilePolicy
    render json: {
      data: model_serializer.new(entry, params: { current_user: current_user }).serializable_hash[:data][:attributes]
    }, status: :ok
  end

  private

  def permitted_attrs
    [:id]
  end

  def model_serializer
    ProfileSerializer
  end

  def entry
    User.find(params[:id])
  end

  def model_class
    :profile
  end
end