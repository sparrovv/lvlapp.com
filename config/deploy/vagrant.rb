require 'puma/capistrano'

set :domain, "192.168.33.10" # digital ocean
set :user, "deployer"
set :port, 22
set :deploy_to, "/home/deployer/#{application}"

set :rails_env, "production"

server domain, :app, :web

role :db, domain, :primary => true
