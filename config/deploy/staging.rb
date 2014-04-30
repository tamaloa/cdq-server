server "staging.my-domain.example.org", :app, :web, :db, :primary => true
set :app_sub_domain, "stage-#{application}"

set :rails_env, "staging"
set :keep_releases, 2