#!/bin/bash

# v1

LIS_USER="<user>"
LIS_EMAIL="<email>"

git clone https://github.com/lignigno/LIS.git /tmp/lis_check_update > /tmp/null 2>&1
/tmp/lis_check_update/code/update.sh "user:$LIS_USER" "email:$LIS_EMAIL"
rm -rf /tmp/null 2>&1
