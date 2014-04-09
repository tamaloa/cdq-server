source 'https://rubygems.org'
source 'http://my-very-own-gemserver.example.org"'

ruby '2.0.0'

gem 'rails'
gem 'sass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'bootstrap-sass', '>= 3.0.0.0'
gem 'devise'
gem 'figaro'
gem 'haml-rails'
gem 'pg'
gem 'therubyracer', :platform=>:ruby
group :development do
  gem 'capistrano-custom'     # Custom capistrano tasks and defaults. Allows to easily deploy to a production and a staging server and additionally to three predefined dev domains.
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'html2haml'
  gem 'quiet_assets'
  gem 'rails_layout'
end
group :test do
  gem 'minitest-wscolor'
  gem 'minitest-reporters'
  gem 'timecop'
end

gem 'flot-rails'            # js-graphs for displaying development over time

gem 'font-awesome-rails'    # Nice icons as font

gem 'newrelic_rpm'          # Ruby performance management system
gem 'airbrake'              # When an uncaught exception occurs, Airbrake will POST the relevant data to the Airbrake server specified in your environment.

gem 'whenever'              # For using cron jobs in Ruby