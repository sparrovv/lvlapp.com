require 'puma/capistrano'

set :domain, "146.185.132.161" # digital ocean
set :user, "sparrovv"
set :port, 22

set :rails_env, "production"

server domain, :app, :web

role :db, domain, :primary => true
