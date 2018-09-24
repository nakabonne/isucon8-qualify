#!/bin/bash

ROOT_DIR=$(cd $(dirname $0)/..; pwd)
DB_DIR="$ROOT_DIR/db"
BENCH_DIR="$ROOT_DIR/bench"

export MYSQL_PWD=isucon

mysql -h 172.17.223.3 -uisucon -e "DROP DATABASE IF EXISTS torb; CREATE DATABASE torb;"
mysql -h 172.17.223.3 -uisucon torb < "$DB_DIR/schema.sql"

if [ ! -f "$DB_DIR/isucon8q-initial-dataset.sql.gz" ]; then
  echo "Run the following command beforehand." 1>&2
  echo "$ ( cd \"$BENCH_DIR\" && bin/gen-initial-dataset )" 1>&2
  exit 1
fi

mysql -h 172.17.223.3 -uisucon torb -e 'ALTER TABLE reservations DROP KEY event_id_and_sheet_id_idx'
gzip -dc "$DB_DIR/isucon8q-initial-dataset.sql.gz" | mysql -h 172.17.223.3 -uisucon torb
mysql -h 172.17.223.3 -uisucon torb -e 'ALTER TABLE reservations ADD KEY event_id_and_sheet_id_idx (event_id, sheet_id)'
mysql -h 172.17.223.3 -uisucon torb -e 'ALTER TABLE reservations ADD KEY user_id_idx (user_id)'
mysql -h 172.17.223.3 -uisucon torb -e 'ALTER TABLE reservations ADD KEY event_id_idx_and_canceled_at_idx (event_id, canceled_at)'
