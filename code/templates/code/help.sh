#!/bin/bash

# v1

LIS_SCRIPTS_DIR="/tmp/<user>/code"

LIS_EXIST_COMMANDS=( $(find "$LIS_SCRIPTS_DIR" -type f -name "*.sh" ! -name "deploy.sh" ! -name "lis.sh" -exec basename {} .sh \;) )

for cmd in "${LIS_EXIST_COMMANDS[@]}"; do
	printf " --> $cmd\n"
done

printf "\n"