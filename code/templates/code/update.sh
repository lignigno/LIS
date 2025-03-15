#!/bin/bash

LIS_VERSION="0.5"
LIS_USER="<user>"
LIS_EMAIL="<email>"
LIS_SAVE_URL="<user_url>"

git clone https://github.com/lignigno/LIS.git /tmp/lis_check_update > /tmp/null 2>&1
rm -rf /tmp/null
# /tmp/lis_check_update/code/update.sh    "$LIS_VERSION" \
#                                         "user:$LIS_USER" \
#                                         "email:$LIS_EMAIL" \
#                                         "user_url:$LIS_SAVE_URL"
/tmp/lis_check_update/code/update.sh "$LIS_VERSION" "$LIS_USER" "$LIS_EMAIL" "$LIS_SAVE_URL"
