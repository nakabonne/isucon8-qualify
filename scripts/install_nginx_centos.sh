#!/bin/bash
set -e

sudo touch /etc/yum.repos.d/nginx.repo

suco cat > /etc/yum.repos.d/nginx.repo << "EOF"
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/mainline/centos/7/$basearch/
gpgcheck=0
enabled=1
EOF

sudo yum install nginx
