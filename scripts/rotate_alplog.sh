#! /bin/bash

set -eu

ALP_LOG_FILE=/var/log/h2o/access.log
ROTATE_ALP_LOG_DIR="$HOME/alp"
ROTATE_ALP_LOG_FILE="$ROTATE_ALP_LOG_DIR/alp-$(date '+%Y%m%d%H%M%S').log"

rotate() {
  echo 'rotate'

  mkdir -p "$ROTATE_ALP_LOG_DIR"
  sudo cp "$ALP_LOG_FILE" "$ROTATE_ALP_LOG_FILE"
  sudo truncate --size 0 $ALP_LOG_FILE
}

rotate
