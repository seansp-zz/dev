#!/bin/bash
wget https://releases.hashicorp.com/packer/1.4.1/packer_1.4.1_linux_amd64.zip
unzip packer_1.4.1_linux_amd64.zip -d packer
sudo apt install unzip -y
unzip packer_1.4.1_linux_amd64.zip -d packer
sudo mv packer /usr/local/
echo export PATH="$PATH:/usr/local/packer"
