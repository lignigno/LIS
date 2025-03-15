#!/bin/bash

LIS_USER="<user>"
LIS_EMAIL="<email>"

LIS_PROJECT_DIR="/tmp/$LIS_USER"
LIS_DST_DIR=$LIS_PROJECT_DIR/save
LIS_SRC_DIR=~/Desktop

# LIS_DIRS=($(find $LIS_SRC_DIR -mindepth 1 -maxdepth 1 -type d -exec basename {} \;))
LIS_DIRS=($(ls -A $LIS_SRC_DIR))

# ___________________________________________________________________________SUB FUNCTIONS

save_home_files() {
	echo $(ls -Ap | grep -v /) $LIS_DST_DIR | xargs cp -rf
}

#                                                                                        |
# ---------------------------------------------------------------------------------------|
#                                                                                        |

save_dirs() {
	for item in "${LIS_DIRS[@]}"; do
		if [[ "$item" == "Library" ]]; then
			rsync -aq --delete 	--exclude='Trial' \
								--exclude='Caches' \
								--exclude='Metadata' \
								--exclude='Containers' \
								--exclude='Application Support' \
								$LIS_SRC_DIR/$item $LIS_DST_DIR
			continue
		elif [[ "$item" == "Public" || "$item" == ".Trash" || "$item" == "Library" ]]; then
			continue
		fi

		rsync -aq --delete $LIS_SRC_DIR/$item $LIS_DST_DIR
	done
}

#                                                                                        |
# ---------------------------------------------------------------------------------------|
#                                                                                        |

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

cd $LIS_SRC_DIR

# save_home_files
# save_dirs
rsync -av --delete $LIS_SRC_DIR $LIS_DST_DIR
send_to_repository

printf "\033[1;38;2;0;255;255m\n"
printf "saved"
printf "\033[1;38;2;255;255;0m"
printf " :)\033[0m\n\n"
