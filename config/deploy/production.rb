require 'puma/capistrano'

set :domain, "146.185.132.161" # digital ocean
set :user, "deployer"
set :port, 22

set :rails_env, "production"
set :deploy_to, "/home/deployer/#{application}"

server domain, :app, :web

role :db, domain, :primary => true
