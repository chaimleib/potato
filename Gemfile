source 'https://rubygems.org'
ruby '2.2.2'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.3'
# Use sqlite3 as the database for Active Record
#gem 'sqlite3'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

### CUSTOM ###
gem 'haml-rails'
gem 'puma'
gem 'mysql2', '~> 0.3.18'
gem 'bcrypt', '~> 3.1.10'     # password hashes
gem 'jira-ruby'               # access to Jira and JQL (potato_core)
gem 'nokogiri'                # parse and scrape HTML (potato_core)
gem 'crummy', '~> 1.8.0'      # breadcrumbs in header

# gem 'momentjs-rails', '>=2.9.0'                     # supports bootstrap3-datetimepicker
# gem 'bootstrap3-datetimepicker-rails', '~> 4.7.14'  # nice DateTime picker
# gem 'bootstrap_sortable_rails', '~> 1.8.0'          # nice tables
# gem 'rails-timeago'

group :production do
  gem 'rails_12factor', '~> 0.0.2'
  gem 'pry'   # remove ASAP; added to stop activesupport from complaining
end


### DEV ####
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  
  ### CUSTOM ###
  gem 'better_errors'
  gem 'factory_girl_rails', '~> 4.5'
  gem 'rspec-rails', '~> 3.0'
  gem 'dotenv-rails'
  gem 'awesome_print'
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-nav'
end

