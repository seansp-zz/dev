#!/bin/bash
sudo apt-get install -y linux-virtual linux-tools-virtual linux-cloud-tools-virtual linux-image-extra-virtual openssh-server
wget https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update -y
sudo apt-get install -y lsvmtools

pushd /opt/lsvmtools-1.0.0-x86-64
echo "## Final Step :: sudo ./lsvmprep"
