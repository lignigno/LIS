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

LIS_VERSION="0.lignigno.0.1"
LIS_REC_KEYS=("user" "email")
LIS_SCRIPT_DIR=$(dirname "$(realpath "$0")")

# _______________________________________________________________________________MAIN CODE

cd $LIS_SCRIPT_DIR
LIS_REP=$(git rev-parse --show-toplevel)
trap 'rm -rf "$LIS_REP"' EXIT

if [[ "$LIS_VERSION" == "$1" ]]; then
	printf "Nothing to update\n"
	exit 0
fi

# update local code

# remove user folder code
# cp code to user folder
# sed files
# write UPDATED

for arg in "$@"; do
	key=$(echo "$arg" | cut -d: -f1 | tr -d '"')
	value=$(echo "$arg" | cut -d: -f2-)
	echo -e "$key:$value"
done
