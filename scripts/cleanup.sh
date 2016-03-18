#!/bin/bash -eux

# Uninstall Ansible and remove PPA.
apt-get -y remove --purge ansible
apt-add-repository --remove ppa:ansible/ansible
apt-get autoremove
apt-get update

# Delete unneeded files.
rm -f /home/vagrant/*.sh

# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
sync
