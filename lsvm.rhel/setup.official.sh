#!/bin/bash
sudo yum install -y hyperv-daemons openssh-server 
sudo service sshd start

sudo rpm -Uvh https://packages.microsoft.com/config/rhel/7/packages-microsoft-prod.rpm
