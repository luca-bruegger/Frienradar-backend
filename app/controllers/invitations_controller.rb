# frozen_string_literal: true

class InvitationsController < CrudController
  def create(options = nil)
    build_entry
    authorize entry
    if entry.save
      puts "entry: #{entry}"
      headings = { en: "Friend request", de: "Freundschaftsanfrage" }
      contents = { en: "From " + friend.username, de: "Von " + friend.username }

      send_notification(friend, headings: headings, contents: contents)
      send_socket_notification(friend, 'received')
      send_socket_notification(current_user, 'sent')
      render_entry({ status: :created })
    else
      render_errors
    end
  end

  def destroy(options = nil)
    authorize entry
    if entry.destroy
      user = User.find(entry.user_id)
      friend = User.find(entry.friend_id)
      headings = { en: "Request rejected", de: "Freundschaftsanfrage abgelehnt" }
      contents = { en: friend.username, de: friend.username }

      send_notification(user, headings: headings, contents: contents)
      send_socket_notification(user, 'rejected')
      head :no_content
    else
      render_errors
    end
  end

  def accept
    authorize entry
    if entry.accept
      user = User.find(entry.user_id)
      headings = { en: "Request accepted", de: "Freundschaftsanfrage angenommen" }
      contents = { en: current_user.username, de: current_user.username }

      send_notification(user, headings: headings, contents: contents)
      send_socket_notification(user, 'accepted')
      render_entry({ status: :ok })
    else
      render_errors
    end
  end

  private

  def user_not_authorized
    render json: { message: 'Friend request already sent.' }, status: :forbidden
  end

  def send_notification(user, headings: nil, contents: nil)
    api_instance = OneSignal::DefaultApi.new
    notification = OneSignal::Notification.new(
      app_id: ENV['ONESIGNAL_APP_ID'],
      headings: headings,
      contents: contents,
      ios_badge_type: "Increase",
      ios_badge_count: 1,
      include_external_user_ids: [user.guid]
    )

    begin
      # Create notification
      result = api_instance.create_notification(notification)
      p result
    rescue OneSignal::ApiError => e
      puts "Error when calling DefaultApi->create_notification: #{e}"
    end
  end

  def send_socket_notification(user, type)
    ActionCable.server.broadcast(
      "invitations_channel_#{user.guid}",
      {
        type: type,
        data: InvitationSerializer.new(entry).serializable_hash[:data][:attributes]
      }
    )
  end

  def permitted_attrs
    [:friend_guid]
  end

  def fetch_entries
    current_user.received_invitations
  end

  def build_entry
    instance_variable_set(:"@#{model_identifier}", current_user.invite(friend.id))
  end

  def friend
    User.find_by(guid: model_params[:friend_guid] || entry.friend_id)
  end

  def model_serializer
    InvitationSerializer
  end
end