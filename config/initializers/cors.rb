# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    if Rails.env.development?
      origins ['*']
      resource '*',
               headers: :any,
               expose: ['Authorization'],
               methods: %i[get post put patch delete options head],
               credentials: false
    else
      if Rails.env.staging?
        origins ENV['STAGING_CORS_ORIGINS'].split(',')
        resource '*',
                 headers: :any,
                 expose: ['Authorization'],
                 methods: %i[get post put patch delete options head],
                 credentials: true
      else
        origins ['*.frienradar.com']
        resource '*',
                 headers: :any,
                 expose: ['Authorization'],
                 methods: %i[get post put patch delete options head]
      end
    end
  end
end
