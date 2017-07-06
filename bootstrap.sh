#!/usr/bin/env bash
#Install Java, maven and git

sudo apt update

#Installing Git
sudo apt-get install -y git

#Installing Java
yes | sudo add-apt-repository ppa:webupd8team/java
sudo apt update
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
sudo apt install -y oracle-java8-installer
javac -version
sudo apt install oracle-java8-set-default

#Installing Jenkins
sudo wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install -y jenkins
sudo su jenkins -s /bin/bash #change to jenkins user
ssh-keygen
#make it able to look at secret file -R used to make everything inside available
sudo chmod -R 755 /var/lib/jenkins/secrets  
#change back to vagarant user
su vagrant 
sudo service jenkins start

#Installing Jira
cd /vagrant_data
sudo chmod a+x atlassian-jira-software-7.4.0-x64.bin
sudo ./atlassian-jira-software-7.4.0-x64.bin -q -varfile response.varfile

#Install Nexus
cd /opt
sudo mkdir nexus
cd nexus
sudo cp -r /vagrant_data/nexus/* /opt/nexus
#needs to change things in the config file
#Cant figure it out how to do it manually.
sudo chmod a+x /opt/nexus/bin/nexus
sudo chown -R vagrant:vagrant /opt/nexus
cd /opt/nexus/bin
sudo ./nexus start


