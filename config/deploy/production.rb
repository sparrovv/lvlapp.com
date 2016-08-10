set :domain, "146.185.132.161" # digital ocean

set :rails_env, "production"

server fetch(:domain), user: 'deployer', roles: ["app", "web", "db"]

#role :db, fetch(:domain), :primary => true
