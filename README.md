# MDW Setup

Middlware and Web Services is a CTU course part of Web engineering curiculla.

This is example of setup and installation scripts for Oracle Web Logic and Oracle Service Bus. It also includes script to create new domain for single server development mode. 

## Prerequisites

- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](https://www.vagrantup.com/)
  * Plugins 
    * vagrant plugin install vagrant-vbguest
    * vagrant plugin install vagrant-omnibus
- [Oracle Service Bus 11gR1](http://www.oracle.com/technetwork/middleware/service-bus/downloads/index.html)
  * Download **generic** versions (Registration required)
    * Oracle WebLogic Server 11gR1 (10.3.6) + Coherence - Package Installer
    * Oracle Service Bus
  * Copy Web Logic Server jar to oracle_install and rename to wls.jar
  * Unzip Service Bus file, copy to oracle_install and rename the folder to osb

## Vagrant 

```
# start virtual server and install java + xfce + chromium
vagrant up
```

```
# login to vagrant virtual server
vagrant ssh
```

## Manual setup and instalation (Debian & Ubuntu scripts)

All scripts are available in oracle_scripts. Following example is for vagrant box but with modifications can be used in other environments too.


```
# login to vagrant virtual server
vagrant ssh
# generate all scripts for silent installation
cd /vagrant/oracle_scripts/
./generate_scripts.sh

# install web logic
./wls-silent.sh
# install service bus
./osb-silent.sh
# create domain
./wls-domain.sh
```


## Start server 

```
# login to vagrant virtual server
vagrant ssh

# start server
/vagrant/oracle_mw/user_projects/domains/base_domain/startWebLogic.sh

```


## Start XFCE

Go to the VirtualBox window:

```
# login with username vagrant and password vagrant
startx
```

## Web Logic Test
```
Open Web Console in your web browser
http://127.0.0.1:7001/console
Login
Username: weblogic
Password: welcome1
Login
```

## Oracle Service Bus Test

```
Open Web Console in your web browser
http://127.0.0.1:7001/sbconsole
Login
Username: weblogic
Password: welcome1
Login
```
