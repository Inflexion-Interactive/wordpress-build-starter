require 'mina/bundler'
require 'mina/rails'
require 'mina/git'

set :user, 'root'
set :domain, '104.236.219.10'
set :repository, 'https://github.com/Inflexion-Interactive/wordpress-build-starter.git'

# Read/set environment
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

  invoke :'db:setup'

  invoke :'apache:setup'
  invoke :'apache:enable'
end

desc "Create database"
task :'db:setup' => :environment do
  puts "Enter a user to associate with #{env} database (in wp-config.php):"
  db_user = STDIN.gets.chomp
  puts "Enter user password (in wp-config.php):"
  db_pass = STDIN.gets.chomp
  queue! %{
    echo "-----> Provisioning #{env} database..."
    Q1="CREATE DATABASE IF NOT EXISTS wordpress_#{env};"
    Q2="GRANT ALL PRIVILEGES ON wordpress_#{env}.* TO #{db_user}@localhost IDENTIFIED BY '#{db_pass}';"
    Q3="FLUSH PRIVILEGES;"
    SQL="${Q1}${Q2}${Q3}"
    #{echo_cmd %[mysql -uroot -e "$SQL"]}
    echo "-----> Done"
  }
end

desc "Create Apache site file"
task :'apache:setup' => :environment do
  vhost = create_host_file(env)
  queue! %{
    echo "-----> Create Temporary Apache Virtual Host"
    echo "#{vhost}" > /tmp/#{env}.conf
    echo "-----> Copy Virtual Host file to /etc/apache2/sites-available/"
    #{echo_cmd %[sudo cp /tmp/#{env}.conf /etc/apache2/sites-available/]}
    echo "-----> Remove Temporary Apache Virtual Host"
    rm /tmp/#{env}.conf
    echo "-----> Done"
  }
end

desc "Enable new Apache host file"
task :'apache:enable' => :environment do
  queue! %{
    echo "-----> Enable Apache Virtual Host"
    #{echo_cmd %[sudo a2ensite #{env}]}
    echo "-----> Restart Apache"
    #{echo_cmd %[sudo service apache2 reload]}
  }
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:cleanup'

    to :launch do
      queue "sudo service apache2 restart"
    end
  end
end

# Helper Functions
def create_host_file(env)
  case env
  when 'staging'
    return <<-HOSTFILE
      Listen *:4567
      <VirtualHost *:4567>
        ServerName 104.236.219.10
        DocumentRoot #{deploy_to!}/#{current_path!}
        <Directory />
          Options FollowSymLinks
          AllowOverride None
        </Directory>
        <Directory #{deploy_to!}/#{current_path!}
          Options Indexes FollowSymLinks MultiViews
          AllowOverride None
          Order allow,deny
          Allow from all
        </Directory>
      </VirtualHost>
    HOSTFILE
  when 'production'
    return <<-HOSTFILE
      <VirtualHost *:80>
        ServerName 104.236.219.10
        DocumentRoot #{deploy_to!}/#{current_path!}
        <Directory />
          Options FollowSymLinks
          AllowOverride None
        </Directory>
        <Directory #{deploy_to!}/#{current_path!}
          Options Indexes FollowSymLinks MultiViews
          AllowOverride None
          Order allow,deny
          Allow from all
        </Directory>
      </VirtualHost>
    HOSTFILE
  end
end
