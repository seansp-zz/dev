#!/bin/bash
sudo yum install -y lsvmtools
cp /opt/lsvmtools-1.0.0/lsvmprep /opt/lsvmtools-1.0.0/lsvmprep.backup
cp ~/dev/lsvmprep /opt/lsvmtools-1.0.0/lsvmprep
pushd /opt/lsvmtools-1.0.0