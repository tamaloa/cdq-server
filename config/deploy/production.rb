server "production.my-domain.example.org", :app, :web, :db, :primary => true
set :app_sub_domain, application

set :rails_env, "production"
set :keep_releases, 5

set :branch, 'default'

# You propably want to do backups before production deploys
before "deploy:migrate", "db:postgres:dump"
