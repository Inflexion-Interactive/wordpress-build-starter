require 'mina/bundler'
require 'mina/rails'
require 'mina/git'

set :user, 'root'
set :domain, '104.236.219.10'
set :repository, 'https://github.com/Inflexion-Interactive/wordpress-build-starter.git'

#set :term_mode, nil
#set :forward_agent, true

# Read/set environment variable
# Default `staging`
# e.g. `mina <task> on=production`
set :env, "#{ENV['on'] == 'production' ? 'production' : 'staging' }"

task :environment do
  set :deploy_to, "/var/www/#{env}"
  set :branch, "#{env == 'production' ? 'master' : 'staging'}"
end

task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:cleanup'

    to :launch do
      queue "sudo service apache2 reload"
    end
  end
end
