# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'awesome_events'
set :repo_url, 'git@github.com:yamashun/perfect_rails_awesome_events'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/awesome-events'

# Default value for :scm is :git
set :scm, :git

set :keep_releases, 5

set :log_level, :debug


# Default value for default_env is {}
set :default_env, {
  rbenv_root: "/usr/local/rbenv",
  path: "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH"
}

set :linked_dirs, %w{tmp/pids}

set :unicorn_rack_env, "none"
set :unicorn_config_path, 'config/unicorn.rb'

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
