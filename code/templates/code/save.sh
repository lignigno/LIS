#!/bin/bash

LIS_USER="<user>"
LIS_EMAIL="<email>"

LIS_PROJECT_DIR="/tmp/$LIS_USER"
LIS_SAVE_DIR=$LIS_PROJECT_DIR/save

LIS_DIRS=($(find ~/Desktop -mindepth 1 -maxdepth 1 -type d -exec basename {} \;))

# ___________________________________________________________________________SUB FUNCTIONS

save_home_files() {
	echo $(ls -Ap | grep -v /) $LIS_SAVE_DIR | xargs cp -rf
}

#                                                                                        |
# ---------------------------------------------------------------------------------------|
#                                                                                        |

save_dirs() {
	for dir in "${LIS_DIRS[@]}"; do
		if [[ "$dir" == "Library" ]]; then
			rsync -aq --delete 	--exclude='Trial' \
								--exclude='Caches' \
								--exclude='Metadata' \
								--exclude='Containers' \
								--exclude='Application Support' \
								~/$dir $LIS_SAVE_DIR
			continue
		elif [[ "$dir" == "Public" || "$dir" == ".Trash" || "$dir" == "Library" ]]; then
			continue
		fi

		rsync -aq --delete ~/$dir $LIS_SAVE_DIR
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

if [ ! -d $LIS_SAVE_DIR ]; then
	mkdir $LIS_SAVE_DIR
fi

cd ~

save_home_files
save_dirs

send_to_repository

printf "\033[1;38;2;0;255;255m\n"
printf "saved"
printf "\033[1;38;2;255;255;0m"
printf " :)\033[0m\n\n"
