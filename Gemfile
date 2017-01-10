source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'yaml_db'
# Use Puma as the app server
# gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use Haml for views and generators
gem 'haml'
gem 'haml-rails'

# User interface gems required by the HOMER theme
gem 'bootstrap-sass', '3.3.6'
gem 'font-awesome-sass', '~> 4.7'

# Extensions to Bootstrap
gem 'bootstrap_form'
gem 'bootstrap-datepicker-rails'
gem 'clockpicker-rails'
gem 'active_link_to'
gem 'select2-rails'
gem 'summernote-rails'
gem 'unobtrusive_flash'

# Pagination, infinite scrolling, and low magic search
gem 'kaminari'
gem 'jquery-infinite-pages'
gem 'searchlight'

# Image uploads
gem 'shrine'
gem 'image_processing'
gem 'mini_magick', '>= 4.3.5'
gem 'dropzonejs-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# User authentication and authorization
gem 'devise'
gem 'two_factor_authentication', git: 'https://github.com/Houdini/two_factor_authentication.git'
gem 'rolify'
gem 'authority'

# QRCode generation
gem 'rqrcode'

# Country and language selections
gem 'country_select'
gem 'iso-639'

# Gems to import records from zip files
gem 'rubyzip'
gem 'activerecord-import'

# HTTP abstraction for seeding the database
gem 'httparty'

# Date library for FullCalendar
gem 'momentjs-rails'

# Facilities for static pages
gem 'high_voltage'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Entity-Relationship Diagrams.
  gem 'rails-erd'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
