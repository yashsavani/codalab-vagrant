# codalab-vagrant
Vagrantfile and provisioning scripts to run a developer version of Codalab Worksheets (https://worksheets.codalab.org/) locally on a Vagrant VM.

## Installation Procedure
1. Install Vagrant on your local system (https://www.vagrantup.com/docs/installation/).
2. `git clone https://github.com/yashsavani/codalab-vagrant`
3. `cd codalab-vagrant`
4. `vagrant up`
5. `vagrant ssh`
6. `cd /vagrant/ && bash setup_vagrant.sh`
7. `cd /vagrant/ && bash run_servers.sh`
8. Visit http://localhost:4567
9. Create a user account
10. `screen -x REST`
11. visit the link provided
12. Use Account to login
