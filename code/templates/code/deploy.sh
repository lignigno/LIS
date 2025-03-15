#!/bin/bash

LIS_USER="<user>"

/tmp/$LIS_USER/code/update.sh

LIS_SAVE_DIR=~

LIS_DIRS=($(find /tmp/$LIS_USER/save -mindepth 1 -maxdepth 1 -type d -exec basename {} \;))

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



cd /tmp/$LIS_USER/save

save_home_files
save_dirs

echo "alias lis=\"/tmp/$LIS_USER/code/lis.sh\"" >> ~/.zshrc

printf "\033[1;38;2;0;255;255m\n"
printf "LIS deployed"
printf "\033[0m\n\n"
