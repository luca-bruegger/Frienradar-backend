module ApplicationHelper
  def confirmation_url(token)
    "http://localhost:8100/additional-login-data?confirmation_token=#{token}"
  end

  def reset_password_url(token)
    "http://localhost:8100/reset-password?reset_password_token=#{token}"
  end
end
