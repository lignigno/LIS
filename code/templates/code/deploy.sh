#!/bin/bash

LIS_USER="<user>"

/tmp/$LIS_LOGIN/code/update.sh

echo "alias lis=\"/tmp/$LIS_USER/code/lis.sh\"" >> ~/.zshrc

printf "\033[1;38;2;0;255;255m\n"
printf "LIS deployed"
printf "\033[0m\n\n"
