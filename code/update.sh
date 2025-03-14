#!/bin/bash

LIS_SCRIPT_DIR=$(dirname "$(realpath "$0")")

for arg in "$@"; do
	key=$(echo "$arg" | cut -d: -f1 | tr -d '"')
	value=$(echo "$arg" | cut -d: -f2-)
	echo -e "$key:$value"
done

cd $LIS_SCRIPT_DIR
LIS_REP=$(git rev-parse --show-toplevel)
trap 'rm -rf "$LIS_REP"' EXIT