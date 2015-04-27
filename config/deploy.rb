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
# `mina <task> on=production`
set :env, "#{ENV['on'] == 'production' ? 'production' : 'staging' }"

task :environment do
  set :deploy_to, "#{env == 'production' ? '/var/www/production' : '/var/www/staging'}"
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
    invoke :'wp:config'
    invoke :'git:clone'
    invoke :'deploy:cleanup'

    to :launch do
      queue "sudo service apache2 reload"
    end
  end
end

desc "Set correct wp-config.php file"
task :'wp:config' => :environment do
  queue! %[rm wp-config.php]
  queue! %[cp "config/wpconfigs/wp-config.#{env}.php ."]
  queue! %[git add --all; git commit -am "deploy commit via mina; git push origin #{branch}"]
end


# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers

