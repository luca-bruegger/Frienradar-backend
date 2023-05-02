module ApplicationHelper
  def confirmation_url(token)
    ENV['DEEPLINK_HOST'] + "/additional-login-data?confirmation_token=#{token}"
  end

  def reset_password_url(token)
    ENV['DEEPLINK_HOST'] + "/reset-password?reset_password_token=#{token}"
  end
end
