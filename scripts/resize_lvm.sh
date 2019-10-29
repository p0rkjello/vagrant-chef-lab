#!/bin/bash

set -e
set -x

echo ==== Resizing Drive =======================================================

# Extend Volume to take up free space
sudo parted /dev/sda resizepart 2 100%
sudo pvresize /dev/sda2
sudo lvextend -l +100%FREE /dev/centos/root
sudo xfs_growfs /dev/centos/root
