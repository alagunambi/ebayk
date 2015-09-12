set :port, 22
set :user, 'root'
set :deploy_via, :remote_cache
set :use_sudo, false

server '50.116.44.11',
  roles: [:web, :app, :db],
  port: fetch(:port),
  user: fetch(:user),
  primary: true

set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"

set :ssh_options, {
  forward_agent: true,
  auth_methods: %w(publickey),
  user: 'root',
}

set :rails_env, :production
set :conditionally_migrate, true   