#!/usr/bin/env bash

cd /vagrant/codalab-worksheets && ./setup.sh
cd /vagrant/codalab-cli && codalab/bin/cl config server/engine_url mysql://codalab:password@localhost:3306/codalab_bundles
cd /vagrant/codalab-cli && scripts/create-root-user.py password
echo -e "codalab\npassword" > /home/vagrant/.codalab/root.password
chmod 600 /home/vagrant/.codalab/root.password


