# frozen_string_literal: true

class RequestedUsersController < CrudController

  def show
    authorize model_class, policy_class: RequestedUserPolicy
    render_entry
  end

  private

  def render_entry
    render json: {
      data: model_serializer.new(entry).serializable_hash[:data]
    }, status: :ok
  end

  def model_class
    :requested_user
  end

  def model_serializer
    RequestedUserSerializer
  end

  def entry
    User.find(current_user.pending_invitations.paginate(page: page).pluck(:friend_id))
  end
end
