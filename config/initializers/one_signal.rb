# Setup for OneSignal notifications

raise "Missing ENV['ONESIGNAL_API_KEY']" unless ENV['ONESIGNAL_API_KEY']
raise "Missing ENV['ONESIGNAL_USER_KEY']" unless ENV['ONESIGNAL_USER_KEY']

OneSignal.configure do |config|
  # Configure Bearer authorization
  config.app_key = ENV['ONESIGNAL_API_KEY']
  config.user_key = ENV['ONESIGNAL_USER_KEY']
end