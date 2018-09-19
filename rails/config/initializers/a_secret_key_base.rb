secret_key_base = ENV['<%= app_name.upcase %>_SECRET_KEY_BASE'].presence
secret_key_base || raise("You must set <%= app_name.upcase %>_SECRET_KEY_BASE")

Rails.application.config.secret_key_base = secret_key_base
