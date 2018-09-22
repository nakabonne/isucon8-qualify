#!/bin/bash
set -e

git pull
echo "$(tput setaf 2)Pull Succeeded! $(tput sgr0)"
echo ""

# reverse proxy
sudo cp etc/h2o.conf /etc/h2o/h2o.conf
sudo cp etc/nginx.conf /etc/nginx/nginx.conf

# log rotate
make rotate
make mysqldumpslow
echo "$(tput setaf 2)log rotate Succeeded! $(tput sgr0)"
echo ""

# app
cd /home/isucon/torb/webapp/go
make build


sudo /usr/sbin/h2o -t -c /etc/h2o/h2o.conf
sudo systemctl restart h2o

sudo /usr/sbin/nginx -t
sudo service nginx reload
echo "$(tput setaf 2)reverse proxy reload Succeeded! $(tput sgr0)"
echo ""

sudo systemctl restart torb.go
echo "$(tput setaf 2)application reload Succeeded! $(tput sgr0)"
echo ""

echo "$(tput setaf 2)############################$(tput sgr0)"
echo "$(tput setaf 2)## Restart Succeeded!!! ✔︎ ##$(tput sgr0)"
echo "$(tput setaf 2)############################$(tput sgr0)"
echo ""
