#!/bin/bash

set -e
set -x

echo ==== Installing Requirements ==============================================
# Install required dependencies
sudo yum install -y git

echo ==== Clone Habitat on-prem ================================================
# Clone on-prem repo
git clone https://github.com/habitat-sh/on-prem-builder.git
cd on-prem-builder
sudo cp bldr.env.sample bldr.env