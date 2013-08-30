default_run_options[:shell] = '/bin/bash -l'
require 'bundler/capistrano'
require 'capistrano_colors'

load 'deploy/assets'
set :stages, ['production']
set :default_stage, 'production'
require 'capistrano/ext/multistage'

set :application, "landl"
set :deploy_to, "/home/sparrovv/#{application}"
set :scm, :git
set :repository, "git@gitlab.com:sparrovv/landl.git"
set :deploy_via, :remote_cache

set :branch, ENV['branch'] || :master
set :use_sudo, false
set :keep_releases, 5

namespace :r do
  desc "Run a task on a remote server.
  how to run: cap staging r:invoke task=rebuild_table_abc"
  task :invoke do
    run("cd #{deploy_to}/current; bundle exec rake #{ENV['task']} RAILS_ENV=#{rails_env}")
  end
end

after 'deploy:update', 'deploy:cleanup'
after 'deploy:update', 'deploy:migrate'
