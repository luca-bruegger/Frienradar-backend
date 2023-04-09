module ApplicationHelper
  def confirmation_url(token)
    "http://localhost:8100/additional-login-data?confirmation_token=#{token}"
  end
end
