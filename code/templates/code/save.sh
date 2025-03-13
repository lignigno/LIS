#!/bin/bash

# START
# END

PROJECT_DIR=/tmp/<user>
# PROJECT_DIR=/tmp
SAVE_DIR=$PROJECT_DIR/save
# SAVE_DIR="/tmp/test"

DIRS=($(find ~ -mindepth 1 -maxdepth 1 -type d -exec basename {} \;))
DEFAULT_DIRS=()
USER_DIRS=()

# ___________________________________________________________________________SUB FUNCTIONS

save_home_files() {
	echo $(ls -Ap | grep -v /) $SAVE_DIR | xargs cp -rf
}

#                                                                                        |
# ---------------------------------------------------------------------------------------|
#                                                                                        |

save_dirs() {
	for dir in "${DIRS[@]}"; do
		if [[ "$dir" == "Library" ]]; then
			rsync -aq --delete --exclude='Trial' ~/$dir $SAVE_DIR
			continue
		elif [[ "$dir" == "Public" || "$dir" == ".Trash" ]]; then
			continue
		fi

		rsync -aq --delete ~/$dir $SAVE_DIR
	done
}

#                                                                                        |
# ---------------------------------------------------------------------------------------|
#                                                                                        |

send_to_repository() {
	cd $PROJECT_DIR

	git config --global user.email "<email>"
	git config --global user.name "<user>"

	git add . > /tmp/null
	git commit -m "save" > /tmp/null
	git push > /tmp/null

	rm -rf /tmp/null

	if [ $? -ne 0 ]; then
		exit 1
	fi
}

# _______________________________________________________________________________MAIN CODE

if [ ! -d $SAVE_DIR ]; then
	mkdir $SAVE_DIR
fi

cd ~

save_home_files
save_dirs

send_to_repository

printf "\033[1;38;2;0;255;255m\n"
printf "saved"
printf "\033[1;38;2;255;255;0m"
printf " :)\033[0m\n\n"
