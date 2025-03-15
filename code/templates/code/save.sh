#!/bin/bash

LIS_USER="<user>"
LIS_EMAIL="<email>"

LIS_PROJECT_DIR="/tmp/$LIS_USER"
LIS_DST_DIR=$LIS_PROJECT_DIR/save
LIS_SRC_DIR=~

# ___________________________________________________________________________SUB FUNCTIONS

send_to_repository() {
	cd $LIS_PROJECT_DIR

	git config --global user.email "$LIS_EMAIL"
	git config --global user.name "$LIS_USER"

	echo "=====[ SAVING ]=====" 
	git add . > /tmp/null
	git commit -m "save" > /tmp/null
	git push > /tmp/null

	rm -rf /tmp/null

	echo "===================="
	if [ $? -ne 0 ]; then
		printf "\n\033[1;38;2;255;0;0mNOT SAVED\033[0m\n\n"
		exit 1
	fi
}

# _______________________________________________________________________________MAIN CODE

if [ ! -d $LIS_DST_DIR ]; then
	mkdir $LIS_DST_DIR
fi

rsync -aq --delete --exclude='.Trash' \
                   --exclude='Library' \
                   --exclude='Public' \
                   $LIS_SRC_DIR/ $LIS_DST_DIR/
rsync -aq --delete --exclude='Trial' \
                   --exclude='Caches' \
                   --exclude='Metadata' \
                   --exclude='Containers' \
                   --exclude='Application Support' \
                   $LIS_SRC_DIR/Library $LIS_DST_DIR

send_to_repository

printf "\033[1;38;2;0;255;255m\n"
printf "saved"
printf "\033[1;38;2;255;255;0m"
printf " :)\033[0m\n\n"
