require Rails.root.join('config', 'environments', 'production')

Rails.application.configure do
  # --- RAILS ---

  # Don't send emails in staging.
  # Default is :smtp.
  config.action_mailer.delivery_method = :test

  # Really don't send emails in staging.
  # Default is true.
  config.action_mailer.perform_deliveries = false

  # Links in emails point to staging domain.
  config.action_mailer.default_url_options = {
    protocol: Protocool.protocol,
    host: 'staging.example.com'
  }

  # --- MIDDLEWARE ---

  config.middleware.insert_after ::ActionDispatch::Session::CookieStore, ::Rack::Auth::Basic do |_, attempted_password|
    system_password = ENV['<%= app_name.upcase %>_STAGING_BASIC_AUTH_PASSWORD'].presence
    system_password || raise('You need to set <%= app_name.upcase %>_STAGING_BASIC_AUTH_PASSWORD')

    ActiveSupport::SecurityUtils.secure_compare attempted_password,
                                                system_password
  end
end
