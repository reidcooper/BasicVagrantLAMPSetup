# Simple Vagrant/LAMP Set Up
=====

I have use Vagrant a couple of times for projects in which it has become incredibly useful in set up and operation. Its nice for me because I like to keep my computer environment clean and not possibly filled with errors that could potentially harm my computer. Therefore, having a virtual machine environment works for me. I have also used it for some of my college classes which require the LAMP stack, in this case, I just have to run `vagrant up` which loads up the stack and my projects are all ready to go. But, vagrant boxes can be used for anything you can think of not just LAMP stacks. Any type of development environment can work.

I have also included a LAMP Stack set up script which I have written which works as of 3/10/15. Let me know if I have to change it. It automatically installs LAMP including phpmyadmin with default **username: root** and **password: password**. This is currently configured to be the most basic of configuration and has not been tested or meant for anything for production in terms of security etc.. Use this as a guide on how to set up a vagrant machine and LAMP stack if required.

**Remember, you can take snapshots of your virtual machine in virtualbox. This way, it saves the state of the machine at that moment in time so you can revert back to it in case shit hits the fan.**

#### Set Up Vagrant:
----

1. install Vagrant
2. install virtual box
2. make a project directory
3. cd into directory
4. Go to https://atlas.hashicorp.com/boxes/search to find a box
5. Copy name of box
6. (If a box hasn't been added) run in project directory `vagrant box add (NAME i.e. ubuntu/trusty64)`
7. While still in project directory, `vagrant init`
8. Edit Vagrantfile
9. Open up vagrant file within that project directory
	* uncomment `config.vm.network "forwarded_port", guest: 80, host: 8080`
	* uncomment `config.vm.box = "(BOX NAME i.e. ubuntu/trusty64)"`
10. Save File
11. `vagrant up`
12. Finished (Optional Steps Below for Entering Vagrant Machine)
13. `vagrant ssh`
14. cd into /vagrant folder

#### Operation:
----

1. cd into project directory
2. `vagrant up` (if not running)
3. `vagrant halt` (if running)

#### Commands:
----

* `vagrant up`
* `vagrant halt`
* `vagrant ssh`
* `vagrant destroy`
* `exit` (exit vagrant ssh session)

#####How To Install Linux, Apache, MySQL, PHP (LAMP) stack on Ubuntu:
* [LAMP for Ubunut on Digital Ocean](https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu)

#####Reid's LAMP Vagrant Script:
1. Make sure in Project Directory which is shared in the vagrant machine
2. `vagrant ssh`
3. cd into the /vagrant directory
4. run `sh LAMPVagrantSetupScript.sh`
5. Default Passwords for everything is root & password
6. Restart Machine (`exit`, `vagrant halt`, `vagrant up`)

=====
* [Reid's LAMP Vagrant Script](https://gist.github.com/reidcooper/8a9dc24667a313e236a6
)
* MYSQL:
`root`
`password`
* PHPMYADMIN:
`root`
`password`

#####Symlink /vagrant folder to /var/www/html/ directory:
* `sudo ln -s /vagrant/ /var/www/html/vagrant`

#####Random Notes: 
* http://localhost:8080/
* http://localhost:8080/vagrant/
* `ifconfig eth0 | grep inet | awk '{ print $2 }'`

#####Sources:
* [Coolest Guides on the Planet](http://coolestguidesontheplanet.com/getting-started-vagrant-os-osx-10-9-mavericks/)
* [Atlas Hashicorp](https://atlas.hashicorp.com/boxes/search)
* [Sourabhajaj](http://sourabhbajaj.com/mac-setup/Vagrant/README.html)