#!/bin/bash

# ---------------------------------------------------------------------------------------|
# START                                                                             NOTE |
# ---------------------------------------------------------------------------------------|

# for future

# create other variants for other SPECIFIC swithing
# from previous version to current

# ---------------------------------------------------------------------------------------|
# END                                                                               NOTE |
# ---------------------------------------------------------------------------------------|

LIS_VERSION="0.22-debug"
LIS_REC_KEYS=("user" "email" "user_url")
LIS_SCRIPT_DIR=$(dirname "$(realpath "$0")")

# _______________________________________________________________________________MAIN CODE

cd $LIS_SCRIPT_DIR
LIS_REP=$(git rev-parse --show-toplevel)
trap 'rm -rf "$LIS_REP"' EXIT

if [[ "$LIS_VERSION" == "$1" ]]; then
	printf "Nothing to update\n"
	exit 0
fi

# ____________________________________________________________________________START HUECOD

LIS_LOGIN=$2
LIS_EMAIL=$3
LIS_SAVE_URL=$4

cd $LIS_SCRIPT_DIR/templates
echo $(ls -A) /tmp/$LIS_LOGIN/ | xargs cp -rf

sed -i '' "s|<user_url>|$LIS_SAVE_URL|g" /tmp/$LIS_LOGIN/README.md
sed -i '' "s|<user>|$LIS_LOGIN|g"        /tmp/$LIS_LOGIN/README.md
sed -i '' "s|<user>|$LIS_LOGIN|g"        /tmp/$LIS_LOGIN/code/deploy.sh
sed -i '' "s|<user>|$LIS_LOGIN|g"        /tmp/$LIS_LOGIN/code/help.sh
sed -i '' "s|<user>|$LIS_LOGIN|g"        /tmp/$LIS_LOGIN/code/lis.sh
sed -i '' "s|<user>|$LIS_LOGIN|g"        /tmp/$LIS_LOGIN/code/logout.sh
sed -i '' "s|<email>|$LIS_EMAIL|g"       /tmp/$LIS_LOGIN/code/save.sh
sed -i '' "s|<user>|$LIS_LOGIN|g"        /tmp/$LIS_LOGIN/code/save.sh
sed -i '' "s|<user_url>|$LIS_SAVE_URL|g" /tmp/$LIS_LOGIN/code/update.sh
sed -i '' "s|<email>|$LIS_EMAIL|g"       /tmp/$LIS_LOGIN/code/update.sh
sed -i '' "s|<user>|$LIS_LOGIN|g"        /tmp/$LIS_LOGIN/code/update.sh

# ______________________________________________________________________________END HUECOD

/tmp/$LIS_LOGIN/code/save.sh

printf "===================\n"
printf "\033[1;38;2;0;255;0m\n"
printf "                /|\n"
printf "               / /\n"
printf "    LIS   /\  / /\n"
printf "  UPDATED \ \/ /\n"
printf "           \__/\n"
printf "\033[0m\n"
printf "  Version : $LIS_VERSION\n"
printf "\n"
printf "===================\n"
