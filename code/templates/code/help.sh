#!/bin/bash

LIS_VERSION="0.29-fix"
LIS_SCRIPTS_DIR="/tmp/<user>/code"

LIS_EXIST_COMMANDS=( $(find "$LIS_SCRIPTS_DIR" -type f -name "*.sh" ! -name "deploy.sh" ! -name "lis.sh" -exec basename {} .sh \;) )


printf "\nVersion : $LIS_VERSION\n"
printf "\nexisting commands :\n\n"

for cmd in "${LIS_EXIST_COMMANDS[@]}"; do
	printf " --> $cmd\n"
done

printf "\n"
