#!/bin/bash
sudo yum install -y lsvmtools
cp /opt/lsvmtools-1.0.0/lsvmprep /opt/lsvmtools-1.0.0/lsvmprep.backup
cp ~/dev/lsvmprep.sh /opt/lsvmtools-1.0.0/lsvmprep
cp /opt/lsvmtools-1.0.0/scripts/redhat/update_grub_config /opt/lsvmtools-1.0.0/scripts/redhat/update_grub_config.backup
cp ~/dev/update_grub_config.sh /opt/lsvmtools-1.0.0/scripts/redhat/update_grub_config
pushd /opt/lsvmtools-1.0.0