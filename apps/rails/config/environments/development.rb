Rails.application.configure do
  # --- RAILS ---

  # Lazy load all code for boot speedup.
  # Defaults is unclear.
  config.eager_load = false

  # Toggle caching in development
  # See https://github.com/rails/rails/blob/8dd76a7a6ff1bb7105beabb8f834ca54ab1e5fc2/railties/lib/rails/generators/rails/app/templates/config/environments/development.rb.tt#L15-L28
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    # Default is nil
    config.action_controller.perform_caching = true
  else
    # Default is nil
    config.action_controller.perform_caching = false
    # Default is :file_store
    config.cache_store = :null_store
  end

  # Show full error reports.
  config.consider_all_requests_local = true

  # Show outgoing emails in browser popup windows.
  # Default is :smtp
  config.action_mailer.delivery_method = :letter_opener

  # Links in email point to local webserver.
  config.action_mailer.default_url_options = {
    protocol: Protocool.protocol,
    host: '<%= app_name.downcase %>.localhost',
    port: 8080,
  }

  # Raise an error on page load if there are pending migrations.
  # Default is unclear but most likely false.
  config.active_record.migration_error = :page_load

  # Don't let missing translations slip through.
  # Default is unclear but most likely false.
  config.action_view.raise_on_missing_translations = true

  # For one reason or another, assets are not compiled "live" without this.
  # Default is unclear.
  config.assets.debug = true

  # Don't show asset requests in logs.
  # Default is false.
  config.assets.quiet = true

  # If an asset is missing, we want to now right away.
  # Default is true.
  config.assets.unknown_asset_fallback = false

  # When developing, let's save online traffic.
  config.active_storage.service = :local

  # --- MIDDLEWARE ---

  config.middleware.use Rack::HostRedirect, 'www.<%= app_name.downcase %>.dev' => {
    host: '<%= app_name.downcase %>.dev',
    path: '/',
    query: nil,
    exclude: ->(request) { request.path.start_with?('/.well-known/acme-challenge/') }
  }

  config.middleware.insert_after ActionDispatch::Static, Rack::LiveReload, no_swf: true

  # --- GEMS ---

  # Match Bcrypt cost with production for easier debugging
  BCrypt::Engine.cost = 12
end
