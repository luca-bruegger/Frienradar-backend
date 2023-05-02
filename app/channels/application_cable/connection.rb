module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      if user_from_token.present?
        user_from_token
      else
        reject_unauthorized_connection
      end
    end

    def user_from_token
      token = request.params[:access_token]

      begin
        Warden::JWTAuth::UserDecoder.new.call(token, :user, nil)
      rescue JWT::DecodeError
        nil
      end
    end

  end
end
