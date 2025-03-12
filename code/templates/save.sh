#!/bin/zsh

cd /tmp/<user>

git config --global user.email "<email>"
git config --global user.name "<user>"

git add . > /tmp/null
git commit -m "save" > /tmp/null
git push > /tmp/null

rm -rf /tmp/null

if [ $? -ne 0 ]; then
	exit 1
fi

printf "\033[1;38;2;255;0;128m"
printf "saved"
printf "\033[1;38;2;255;255;0m"
printf " :)\n"
printf "\033[1;38;2;255;0;128m"
printf "will be soon\033[0m\n"