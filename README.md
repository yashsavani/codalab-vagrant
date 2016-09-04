# codalab-vagrant
Vagrantfile and provisioning scripts to run a developer version of Codalab Worksheets (https://worksheets.codalab.org/) locally on a Vagrant VM.

## Installation Procedure
1. Install Vagrant on your local system (https://www.vagrantup.com/docs/installation/).
2. `git clone https://github.com/yashsavani/codalab-vagrant`
3. `cd codalab-vagrant`
4. `vagrant up`
5. `vagrant ssh`
6. `cd /vagrant/codalab-worksheets && ./setup.sh`
7. `cd /vagrant/codalab-cli && codalab/bin/cl config server/engine_url mysql://codalab:password@localhost:3306/codalab_bundles`
8. `scripts/create-root-user.py password`
9. `echo -e "codalab\npassword" > /home/vagrant/.codalab/root.password`
10. `chmod 600 /home/vagrant/.codalab/root.password`
11. `cd /vagrant/codalab-worksheets/codalab && screen -dmS website ./manage runserver 127.0.0.1:2700`
12. `cd /vagrant/codalab-cli && screen -dmS XMLRPC codalab/bin/cl server`
13. `screen -dmS REST codalab/bin/cl rest-server`
14. `screen -dmS bundle_manager codalab/bin/cl bundle-manager`
15. `cd /vagrant && screen -dmS worker codalab-cli/worker/worker.sh --server http://localhost:2900 --password /home/vagrant/.codalab/root.password`
16. Visit http://localhost:4567
17. Create a user account
18. `vagrant ssh`
19. `screen -x REST`
20. visit the link provided
21. Use Account to login
