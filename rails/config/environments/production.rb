Rails.application.configure do
  # --- RAILS ---

  # This eager loads most of Rails and your application in memory on boot,
  # allowing both threaded web servers and those relying on copy on write
  # to perform better. Rake tasks automatically ignore this option.
  # Default is unclear.
  config.eager_load = true

  # Caching views etc.
  # Default is unclear.
  config.action_controller.perform_caching = true

  # Links in emails point to official production domain.
  config.action_mailer.default_url_options = {
    protocol: Protocool.protocol,
    host: '<%= app_name.downcase %>.com',
  }

  # Compress JavaScripts and CSS using the uglifier gem.
  config.assets.js_compressor = :uglifier

  # Don't fallback to assets pipeline if a precompiled asset is missed.
  # Default is apparently true as the Heroku build log told me.
  config.assets.compile = false

  # Specifies the header that your server uses for sending files.
  # Default is unclear, let's make it work for Nginx.
  config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect'

  # Do not dump schema after migrations.
  # Defaults to true.
  config.active_record.dump_schema_after_migration = false

  # Force all access to the app over SSL, use HSTS, and use secure cookies.
  config.force_ssl = true

  # Fallback to default locale if a translation is missing.
  config.i18n.fallbacks = true

  # --- MIDDLEWARE ---

  # Redirect www. while allowing LetsEncrypt.
  config.middleware.use Rack::HostRedirect, 'www.<%= app_name.downcase %>.com' => {
    host: '<%= app_name.downcase %>.com',
    path: '/',
    query: nil,
    exclude: ->(request) { request.path.start_with?('/.well-known/acme-challenge/') }
  }

  # --- GEMS ---

  BCrypt::Engine.cost = 12
end
