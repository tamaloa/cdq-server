source 'https://rubygems.org'

gem 'rails', '~> 4.2'
gem 'pg'

gem 'devise'

gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'    #Building api results like html pages
gem 'bootstrap-sass'

gem 'figaro'
gem 'haml-rails'

gem 'therubyracer', :platform=>:ruby

group :development do
  gem 'capistrano-rails'      # Remote multi-server automation tool -> "$ cap deploy" to rollout this app
  gem 'capistrano-passenger'  # Restart passenger web servers on deploys
  gem 'capistrano-figaro'     # Use figaro variables during deployment (i.e. deployment server settings)
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'rubycritic', :require => false
  gem 'bundler-audit'
end
group :test do
  gem 'timecop'
  gem 'test_after_commit'
end

gem 'flot-rails'            # js-graphs for displaying development over time

gem 'font-awesome-rails'    # Nice icons as font

gem 'newrelic_rpm'          # Ruby performance management system
gem 'airbrake', '~> 3.1.0'    #use airbrake version compatible with our errbit
gem 'whenever'              # For using cron jobs in Ruby

gem 'rails_admin', '~> 0' #as long as production runs on ruby 2.0
