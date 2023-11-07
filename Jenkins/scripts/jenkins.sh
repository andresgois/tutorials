#!/bin/sh
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | apt-key add - 
sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list' 
apt-get update 
#sudo apt install jenkins=2.164.3
sudo apt install jenkins=2.346.1
