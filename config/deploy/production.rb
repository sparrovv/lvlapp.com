require 'puma/capistrano'

set :domain, "91.228.199.154"
set :user, "sparrovv"
set :port, 22

set :rails_env, "production"

server domain, :app, :web

role :db, domain, :primary => true
