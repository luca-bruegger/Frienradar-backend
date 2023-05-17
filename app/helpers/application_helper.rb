module ApplicationHelper
  def confirmation_url(token)
    deeplink_host + "/additional-login-data?confirmation_token=#{token}"
  end

  def reset_password_url(token)
    deeplink_host + "/reset-password?reset_password_token=#{token}"
  end

  private

  def deeplink_host
    Rails.env.development? ? 'localhost:8100' : ENV['DEEPLINK_HOST']
  end
end
