#!/bin/bash

for arg in "$@"; do
	key=$(echo "$arg" | cut -d: -f1 | tr -d '"')
	value=$(echo "$arg" | cut -d: -f2-)
	echo -e "$key\t$value"
done
