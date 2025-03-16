#!/bin/bash

LIS_USER="<user>"
LIS_PROJECT_DIR=/tmp/$LIS_USER
LIS_SAVE_DIR=$LIS_PROJECT_DIR/save
LIS_DST_DIR=~


rsync -av \
      --delete \
      --exclude='.Trash' \
      --exclude='Library' \
      --exclude='Public' \
      $LIS_SAVE_DIR/ $LIS_DST_DIR/ 1> /tmp/lilog1 2> /tmp/lierr1

rsync -av \
      --delete \
      --exclude='Trial' \
      --exclude='Caches' \
      --exclude='Metadata' \
      --exclude='Containers' \
      --exclude='Application Support' \
      $LIS_SAVE_DIR/Library/ $LIS_DST_DIR/Library/ 1> /tmp/lilog2 2> /tmp/lierr2

/tmp/$LIS_USER/code/update.sh

echo "alias lis=\"/tmp/$LIS_USER/code/lis.sh\"" >> ~/.zshrc

printf "\033[1;38;2;0;255;255m\n"
printf "LIS deployed"
printf "\033[0m\n\n"
