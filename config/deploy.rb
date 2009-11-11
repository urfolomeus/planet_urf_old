set :application, 'planeturf'
set :user, 'planetu'
set :domain, 'planeturf.net'
set :server_hostname, 'planeturf.net'

#set :git_account, 'put_your_git_account_name_here'

#set :scm_passphrase,  Proc.new { Capistrano::CLI.password_prompt('Git Password: ') }

role :web, server_hostname
role :app, server_hostname
role :db, server_hostname, :primary => true

default_run_options[:pty] = true
set :repository,  "planetu@planeturf.net:/home/planetu/git/planeturf"
set :scm, "git"
set :user, user

ssh_options[:forward_agent] = true
set :branch, "master"
set :deploy_via, :remote_cache
set :git_shallow_clone, 1
set :git_enable_submodules, 1
set :use_sudo, false
set :deploy_to, "/home/planetu/planeturf"

set :group_writable, false