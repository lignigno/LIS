#!/bin/bash

# START
# END

# PROJECT_DIR=/tmp/<user>
PROJECT_DIR=/tmp
# SAVE_DIR=$PROJECT_DIR/save
SAVE_DIR="/tmp/test"

FILES=($(find ~ -maxdepth 1 -type f -exec basename {} \;))
DIRS=($(find ~ -maxdepth 1 -type d -exec basename {} \;))
DEFAULT_DIRS=()
USER_DIRS=()

# ___________________________________________________________________________SUB FUNCTIONS

save_home_files() {
	for i in "${FILES[@]}"; do
		new_files+=("$(printf ~)/$i")
	done

	cp -f $new_files $SAVE_DIR/
}

#                                                                                        |
# ---------------------------------------------------------------------------------------|
#                                                                                        |

get_existing_default_dirs() {
	DESIRED=(	"Desktop" "Documents" "Downloads" "Library"
				"Movies" "Music" "Pictures" "Public")

	for dir in "${DIRS[@]}"; do
		for des in "${DESIRED[@]}"; do
			if [[ "$dir" == "$des" ]]; then
				DEFAULT_DIRS+=("$dir")
			fi
		done
	done
}

#                                                                                        |
# ---------------------------------------------------------------------------------------|
#                                                                                        |

save_default_dirs() {
	for dir in "${DEFAULT_DIRS[@]}"; do
		if [[ "$dir" == "Library" ]]; then
			rsync -aq --delete --exclude='Trial' ~/$dir $SAVE_DIR
			continue
		elif [[ "$dir" == "Public" ]]; then
			continue
		fi

		rsync -aq --delete ~/$dir $SAVE_DIR
	done
}

#                                                                                        |
# ---------------------------------------------------------------------------------------|
#                                                                                        |

save_user_dirs() {

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

save_home_files

get_existing_default_dirs
save_default_dirs

ls -alp $SAVE_DIR
# for i in "${DEFAULT_DIRS[@]}"; do
# 	echo $i
# done

# send_to_repository

printf "\033[1;38;2;0;255;255m\n"
printf "saved"
printf "\033[1;38;2;255;255;0m"
printf " :)\033[0m\n\n"

# ls {Music,Pictures,Desktop,Library,Public,Movies,Documents,Downloads}

# rsync -a --exclude='Trial' ~/Library/ /tmp/save/

# Music
# Pictures
# Desktop
# Movies
# Documents
# Downloads

# # skip
# Library
# |
# |
# |
# \
# Public