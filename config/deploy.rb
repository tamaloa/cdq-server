############################################
# Set all main information here and
# override defaults set by capistrano-custom
############################################

set :application, "collector"
set :repository,  "http://my-private-repo.example.org"
set :parent_domain, "my-domain.example.org"


# We only load our custom recipes after specifying the main variables above
require 'capistrano-custom/recipes'
require 'capistrano-custom/defaults'


# The following tasks are more specific and should only be used if necessary

# Setup cron jobs
#set :whenever_command, "bundle exec whenever"
#require "whenever/capistrano"

#Notify airbrake of deploy
require './config/boot'
require 'airbrake/capistrano'