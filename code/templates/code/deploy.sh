#!/bin/bash

LIS_USER="<user>"
LIS_PROJECT_DIR=/tmp/$LIS_USER
LIS_SAVE_DIR=$LIS_PROJECT_DIR/save
LIS_DST_DIR=~


rsync -aq \
      --delete \
      --exclude='.Trash' \
      --exclude='Library' \
      --exclude='Public' \
      --exclude='go' \
      $LIS_SAVE_DIR/ $LIS_DST_DIR/

rsync -aq \
      --delete \
      --exclude='Trial' \
      --exclude='Caches' \
      --exclude='Metadata' \
      --exclude='Containers' \
      --exclude='Application Support' \
      $LIS_SAVE_DIR/Library/ $LIS_DST_DIR/Library/

/tmp/$LIS_USER/code/update.sh

killall -HUP cfprefsd
killall cfprefsd
killall Finder

printf "\033[1;38;2;0;255;255m\n"
printf "LIS deployed"
printf "\033[0m\n\n"
