#!/bin/bash

set -e
set -x

echo ==== Installing Requirements ==============================================
# Install required dependencies
sudo yum install -y curl policycoreutils-python openssh-server openssh-clients

echo ==== Installing GitLab CE =================================================
# Setup the GitLab RPM repo and then install GitLab CE
curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash
sudo EXTERNAL_URL="http://gitlab.dev.local" yum install -y gitlab-ce
