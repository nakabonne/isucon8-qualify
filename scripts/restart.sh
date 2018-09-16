#!/bin/bash
set -e

git pull

## TODO: h2oのコピー↓こんな感じで
## sudo cp etc/nginx.conf /etc/nginx/nginx.conf

cd /home/isucon/torb/webapp/go
make build

## TODO: h2o.confのシンタックスチェック
## TODO: h2oのリスタート

sudo systemctl restart torb.go

echo ""
echo "$(tput setaf 2)Restart Succeeded!!! ✔︎$(tput sgr0)"
