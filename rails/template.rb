# See https://guides.rubyonrails.org/rails_application_templates.html
def source_paths
  [__dir__]
end

template 'Gemfile'
template 'Guardfile'
template 'Procfile'

template '.gitignore'
template '.ruby-version'
template '.tm_properties'
template 'circle.yml'

template '.env.development'
template '.env.test'
template '.env.test.local'

template 'config/environments/development.rb'
template 'config/environments/staging.rb'
template 'config/environments/production.rb'
template 'config/routes.rb'
remove_file 'config/database.yml'

remove_file 'config/master.key'
remove_file 'config/credentials.yml.enc'
remove_file 'config/initializers/a_secret_key_base.rb'
template 'config/initializers/a_secret_key_base.rb'

remove_file 'tmp/.keep'
remove_file 'log/.keep'
create_file 'tmp/.gitkeep'
create_file 'log/.gitkeep'

remove_file 'app/controllers/concerns/.keep'
create_file 'app/controllers/concerns/concerns/.gitkeep'
remove_file 'app/models/concerns/.keep'
create_file 'app/models/concerns/concerns/.gitkeep'

create_file 'app/assets/stylesheets/components/.gitkeep'
create_file 'app/assets/stylesheets/objects/.gitkeep'
create_file 'app/assets/stylesheets/utilities/.gitkeep'

template 'app/assets/stylesheets/elements/links.sass'
template 'app/assets/stylesheets/elements/lists.sass'
template 'app/assets/stylesheets/elements/page.sass'
template 'app/assets/stylesheets/generic/fonts.sass'
template 'app/assets/stylesheets/settings/_colors.sass'
template 'app/assets/stylesheets/tools/_font_smoothing.sass'
template 'app/assets/stylesheets/tools/_link_states.sass'

remove_file 'app/assets/stylesheets/application.css'
template 'app/assets/stylesheets/application.sass'

template 'app/controllers/home_controller.rb'
template 'app/views/home/index.html.slim'

remove_file 'app/views/layouts/mailer.text.erb'
remove_file 'app/views/layouts/mailer.html.erb'

template 'app/views/layouts/_meta.html.slim'
remove_file 'app/views/layouts/application.html.erb'
template 'app/views/layouts/application.html.slim'

run 'yarn add arise typeface-roboto-condensed typeface-inconsolata'

