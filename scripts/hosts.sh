#!/bin/bash

set -e
set -x

echo ==== Configuring Host =====================================================

cat <<EOF | sudo tee /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.50.10 gitlab.dev.local      gitlab
192.168.50.11 habitat.dev.local     habitat
192.168.50.12 workstation.dev.local workstation
192.168.50.13 node1.dev.local       node1
192.168.50.14 node2.dev.local       node2
EOF
