class InvitationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "invitations_channel_#{user_id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  private

  def user_id
    params[:id]
  end
end
