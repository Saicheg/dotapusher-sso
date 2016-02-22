set :branch, 'master'
set :rails_env, 'production'
set :unicorn_env, 'production'

set :puma_threads, [1, 8]
set :puma_workers, 2

server '52.29.73.227',  user: 'deployer', roles: %w{app web db sidekiq}
