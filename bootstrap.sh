#!/usr/bin/env bash
DBHOST=localhost
DBNAME=codalab_bundles
DBUSER=codalab
DBPASSWD=password
HOME=/vagrant
CODALAB_HOME=/home/vagrant/.codalab

echo -e "\n--- Mkay, installing now... ---\n"

echo -e "\n--- Updating packages list ---\n"
apt-get -qq update

echo -e "\n--- Installing Python 2.7 and Virtual Env ---\n"
apt-get install -y python2.7 python2.7-dev python-virtualenv

echo -e "\n--- Installing npm and nodejs-legacy ---\n"
apt-get install -y npm nodejs-legacy

echo -e "\n--- Install base packages ---\n"
apt-get -y install vim curl build-essential python-software-properties git

# MySQL setup for development purposes ONLY
echo -e "\n--- Install MySQL specific packages and settings ---\n"
debconf-set-selections <<< "mysql-server mysql-server/root_password password $DBPASSWD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DBPASSWD"
apt-get -y install mysql-server libmysqlclient-dev

echo -e "\n--- Setting up our MySQL user and db ---\n"
mysql -uroot -p$DBPASSWD -e "CREATE USER '$DBUSER'@'$DBHOST' IDENTIFIED BY '$DBPASSWD'"
mysql -uroot -p$DBPASSWD -e "CREATE DATABASE $DBNAME"
mysql -uroot -p$DBPASSWD -e "grant all privileges on $DBNAME.* to '$DBUSER'@'$DBHOST' identified by '$DBPASSWD'"

echo -e "\n--- Cloning repositories ---\n"
git clone "https://github.com/codalab/codalab-worksheets" "$HOME/codalab-worksheets"
git clone "https://github.com/codalab/codalab-cli" "$HOME/codalab-cli"

echo -e "\n--- Running setup in both repositories ---\n"
cd $HOME/codalab-worksheets && ./setup.sh 
# Above line doesn't run npm
cd codalab/apps/web && npm install && npm run bower && npm run build &&
chmod a+rx . && chmod a+rx codalab && chmod a+rx codalab/apps && 
chmod a+rx codalab/apps/web && chmod -R a+r codalab/apps/web/static && 
find codalab/apps/web/static -type d -exec chmod a+x {} \;

cd $HOME/codalab-cli && ./setup.sh server

echo -e "\n--- Configuring CodaLab to use Database ---\n"
cd $HOME/codalab-cli && codalab/bin/cl config server/engine_url mysql://$DBUSER:$DBPASSWD@$DBHOST:3306/$DBNAME

echo -e "\n--- Configuring the workers ---\n"
cd $HOME/codalab-cli && scripts/create-root-user.py $DBPASSWD
echo -e "$DBUSER\n$DBPASSWD" > $CODALAB_HOME/root.password
chmod 600 $CODALAB_HOME/root.password

echo -e "\n--- Installing Nginx ---\n"
apt-get -y install nginx

echo -e "\n--- Starting NGINX ---\n"
cd $HOME/codalab-worksheets/codalab && ./manage config_gen
cd $HOME/codalab-worksheets/codalab && ln -sf $PWD/config/generated/nginx.conf /etc/nginx/sites-enabled/codalab.conf
service nginx restart

echo -e "\n--- Setting up Environment Variables ---\n"
export HOME=$HOME
export CODALAB_HOME=$CODALAB_HOME
