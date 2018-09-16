#!/bin/bash
set -e

git pull

sudo cp etc/h2o.conf /etc/h2o/h2o.conf

cd /home/isucon/torb/webapp/go
make build

## TODO: h2o.confのシンタックスチェック
sudo systemctl restart h2o

sudo systemctl restart torb.go

echo ""
echo "$(tput setaf 2)Restart Succeeded!!! ✔︎$(tput sgr0)"
