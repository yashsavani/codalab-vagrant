#!/usr/bin/env bash

pkill screen
cd /vagrant/codalab-worksheets/codalab && screen -dmS website ./manage runserver 127.0.0.1:2700
cd /vagrant/codalab-cli && screen -dmS XMLRPC codalab/bin/cl server
cd /vagrant/codalab-cli && screen -dmS REST codalab/bin/cl rest-server
cd /vagrant/codalab-cli && screen -dmS bundle_manager codalab/bin/cl bundle-manager
cd /vagrant && screen -dmS worker codalab-cli/worker/worker.sh --server http://localhost:2900 --password /home/vagrant/.codalab/root.password
