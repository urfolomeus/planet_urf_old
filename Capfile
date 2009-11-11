load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy'

namespace :deploy do
	task :start, :roles => :app do
   	run "ln -s #{deploy_to}/shared/to_copy/database.yml #{current_path}/config/database.yml"
   	run "ln -s #{deploy_to}/shared/to_copy/environment.rb #{current_path}/config/environment.rb"
   	run "ln -s #{deploy_to}/shared/to_copy/flickr.yml #{current_path}/config/flickr.yml"
    run "ln -s #{deploy_to}/shared/to_copy/twitter.yml #{current_path}/config/twitter.yml"
    run "touch #{deploy_to}/current/tmp/restart.txt"
 	end

 	task :restart, :roles => :app do
   	run "rm -f ~/public_html;ln -s #{deploy_to}/current/public ~/public_html"
    run "rm -f ~/public_html/raystag;ln -s #{deploy_to}/../apps/raystag/current/public ~/public_html/raystag"
    run "rm -f #{current_path}/config/database.yml; ln -s #{deploy_to}/shared/to_copy/database.yml #{current_path}/config/database.yml"
    run "rm -f #{current_path}/config/environment.rb; ln -s #{deploy_to}/shared/to_copy/environment.rb #{current_path}/config/environment.rb"
		run "rm -f #{current_path}/config/flickr.yml; ln -s #{deploy_to}/shared/to_copy/flickr.yml #{current_path}/config/flickr.yml"
    run "rm -f #{current_path}/config/twitter.yml; ln -s #{deploy_to}/shared/to_copy/twitter.yml #{current_path}/config/twitter.yml"
    run "touch #{deploy_to}/current/tmp/restart.txt"
 	end
end