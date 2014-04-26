default_run_options[:shell] = '/bin/bash -l'
require 'bundler/capistrano'
require 'capistrano_colors'

set :whenever_command, "bundle exec whenever"
set :whenever_environment, defer { stage }
require "whenever/capistrano"

load 'deploy/assets'
set :stages, ['production']
set :default_stage, 'production'
require 'capistrano/ext/multistage'

set :application, "lvlapp"
set :deploy_to, "/home/sparrovv/#{application}"
set :scm, :git
set :repository, "git@github.com:sparrovv/lvlapp.com.git"
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
