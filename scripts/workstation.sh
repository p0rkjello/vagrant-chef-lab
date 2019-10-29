#!/bin/bash

set -e
set -x

echo ==== Installing Git =======================================================
sudo yum install -y git

echo ==== Installing Habitat ===================================================
curl https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh | sudo bash

# TODO
# Chef
