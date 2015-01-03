source 'https://rubygems.org'
ruby '2.1.5'

def darwin_only(require_as)
  RUBY_PLATFORM.include?('darwin') && require_as
end

def linux_only(require_as)
  RUBY_PLATFORM.include?('linux') && require_as
end

# Standard Rails gems
gem 'rails', '4.2.0'
gem 'sass-rails', '5.0.0'
gem 'uglifier', '2.6.0'
gem 'coffee-rails', '4.1.0'
gem 'jquery-rails', '4.0.2'
gem 'turbolinks', '2.5.3'
gem 'jbuilder', '2.2.6'
gem 'bcrypt', '3.1.9'

# Make links from text
gem 'rails_autolink', '~> 1.1'

# Necessary for Windows OS (won't install on *nix systems)
gem 'tzinfo-data', platforms: [:mingw, :mswin]

# Kaminari: https://github.com/amatsuda/kaminari
gem 'kaminari', '0.16.1'

# Friendly_id: https://github.com/norman/friendly_id
gem 'friendly_id', '5.0.4'

# Font-awesome: https://github.com/FortAwesome/font-awesome-sass
gem 'font-awesome-sass', '4.2.2'

# Bootstrap 3: https://github.com/twbs/bootstrap-sass
gem 'bootstrap-sass', '3.3.1.0'

gem "bower-rails", "~> 0.9.1"


group :development, :test do
  gem 'byebug', '3.5.1'
  gem 'web-console', '2.0.0'

  # Figaro: https://github.com/laserlemon/figaro
  gem 'figaro', '1.0.0'
  
  # Spring: https://github.com/rails/spring
  gem 'spring', '1.2.0'
  gem "annotate", "~> 2.6.0.beta2"
  gem "letter_opener"
  gem 'quiet_assets', '~> 1.0.1'
  gem 'rack-mini-profiler', require: false

  # Better errors handler
  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'rails_best_practices'

  # Docs generator
  gem "sdoc"

  # thin instead webrick
  gem 'thin'
  gem "rspec-rails"
  gem "capybara", '~> 2.2.1'
  gem "pry"
  gem 'factory_girl_rails'

  # Prevent occasions where minitest is not bundled in packaged versions of ruby (see #3826)
  gem 'minitest', '~> 5.5'

  # Generate Fake data
  gem "ffaker"

  # Guard
  gem 'guard-rspec'
  gem 'guard-spinach'

  # Notification
  gem 'rb-fsevent', require: darwin_only('rb-fsevent')
  gem 'growl',      require: darwin_only('growl')
  gem 'rb-inotify', require: linux_only('rb-inotify')

  # PhantomJS driver for Capybara
  gem 'poltergeist', '~> 1.5.1'

  gem 'jasmine', '2.0.2'

  gem "spring-commands-rspec"
  gem 'spork-rails'
  gem "bundler-audit"
  gem "awesome_print"
  gem "pry-rails"
end

group :test do
  gem "capybara-webkit", ">= 1.2.0"
  gem "database_cleaner"
  gem "formulaic"
  gem "shoulda-matchers"
  gem "timecop"
  gem "webmock"
  gem "launchy"

end

gem "bourbon", "~> 3.2.1"
gem "delayed_job_active_record"
gem "email_validator"
gem "flutie"
gem "high_voltage"
gem "i18n-tasks"

gem "neat"
gem "newrelic_rpm"
gem "normalize-rails", "~> 3.0.0"
gem "rack-timeout"
gem "recipient_interceptor"
gem "simple_form"
gem "title"

# PostgreSQL
gem 'pg'

gem 'default_value_for'
# Devise: https://github.com/plataformatec/devise
gem 'devise', '3.4.1'
gem "devise-async"
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-twitter'
gem 'omniauth-github'
gem 'omniauth-facebook'


gem 'rack-cors', require: 'rack/cors'

gem "haml-rails"

# Files attachments
gem "carrierwave"

# Seed data
gem "seed-fu"

# Markdown to HTML
gem "github-markup"
# Required markup gems by github-markdown
gem 'redcarpet', '~> 2.2.2'
gem 'RedCloth'
gem 'rdoc', '~>3.6'
gem 'org-ruby'
gem 'creole', '~>0.3.6'
gem 'wikicloth', '=0.8.1'
gem 'asciidoctor', '= 0.1.4'

gem 'sidekiq', '3.2.1'
gem 'settingslogic'
# Misc
gem "foreman"

# Sanitize user input
gem "sanitize", '~> 2.0'

# Protect against bruteforcing
gem "rack-attack"

# Ace editor
gem 'ace-rails-ap'

# Semantic UI Sass for Sidebar
gem 'semantic-ui-sass', '~> 0.16.1.0'
gem "therubyracer"
gem "gon", '~> 5.0.0'
gem 'request_store'
gem "virtus"

gem 'bitmask_attributes'

# Rails 12factor for Heroku: https://github.com/heroku/rails_12factor
group :production do
  gem 'rails_12factor'
end

# Unicorn: http://unicorn.bogomips.org
group :production do
  gem 'unicorn'
end