# config valid for current version and patch releases of Capistrano
lock "~> 3.17.2"

set :application, "appligo"
set :repo_url, "git@github.com-spr:SprintaleApps/appligo.git"
set :repository, "git@github.com-spr:SprintaleApps/appligo.git"
set :rvm_ruby_version, '3.1.2@appligo'

# Default branch is :master
# set :branch, :main # `git rev-parse --abbrev-ref HEAD`.chomp
set :migration_role, :app

set :keep_releases, 2

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/ubuntu/workspace/sprintale/appligo"
set :current_path, "#{deploy_to}/current"
set :rails_assets_groups, :assets

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads', 'storage'

set :default_env, { rvm_bin_path: '~/.rvm/bin' }

set :puma_threads, [4, 16]
set :puma_workers, 0
set :puma_bind,       "unix:///tmp/sockets/appligo-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{shared_path}/log/puma.access.log"
set :puma_error_log,  "#{shared_path}/log/puma.error.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord


append :linked_files, 'config/database.yml', 'config/credentials.yml.enc', 'config/master.key'

set :ssh_options, {
  keys: %w(/home/mj/.ssh/id_rsa_sprintale),
  forward_agent: true
}
set :repository_cache, "git_cache"
set :deploy_via, :remote_cache

# set :puma_enable_socket_service, true
# set :rvm_type, :user
# set :rvm_ruby_version, '3.1.2'
# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :never
