# codalab-vagrant
Vagrantfile and provisioning scripts to run a developer version of Codalab Worksheets (https://worksheets.codalab.org/) locally on a Vagrant VM.

## Installation Procedure
1. Install Vagrant on your local system (https://www.vagrantup.com/docs/installation/).
2. `git clone https://github.com/yashsavani/codalab-vagrant`
3. `cd codalab-vagrant`
4. `vagrant up`
5. `vagrant ssh`
6. `cd /vagrant/ && bash setup_vagrant.sh`
7. `cd /vagrant/ && run_servers.sh`
16. Visit http://localhost:4567
17. Create a user account
19. `screen -x REST`
20. visit the link provided
21. Use Account to login
