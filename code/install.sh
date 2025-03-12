#!/bin/bash

SAVE_URL=""
LOGIN=""
PASSWORD=""
EMAIL=""
SCRIPT_DIR=$(dirname "$(realpath "$0")")

# ___________________________________________________________________________SUB FUNCTIONS

set_cleaner() {
	cd $SCRIPT_DIR
	REP=$(git rev-parse --show-toplevel)
	trap 'rm -rf "$REP"' EXIT
}

#                                                                                        |
# ---------------------------------------------------------------------------------------|
#                                                                                        |

get_variables() {
	printf "\033[1;38;2;0;255;255m\n"
	printf "1) Create new repository in your "
	printf "\033[1;38;2;0;255;0mGITEA"
	printf " \033[0m(\033[1;38;2;255;255;0mContinue when created\033[0m)"
	read

	while [ -z "$SAVE_URL" ]; do
		printf "\033[1;38;2;0;255;255m\n"
		printf "2) Enter your repository link:\n"
		printf "\033[1;38;2;255;0;128m"
		read SAVE_URL
		if [ -z "$SAVE_URL" ]; then
			printf "\033[1;38;2;255;0;0m"
			printf "Repository link cannot be empty, please enter it.\n"
		fi
	done

	while [ -z "$LOGIN" ]; do
		printf "\033[1;38;2;0;255;255m\n"
		printf "Enter your \033[38;2;0;255;0mlogin\033[38;2;0;255;255m:\n"
		printf "\033[1;38;2;255;0;128m"
		read LOGIN
		if [ -z "$LOGIN" ]; then
			printf "\033[1;38;2;255;0;0m"
			printf "Login cannot be empty, please enter it.\n"
		fi
	done

	while [ -z "$PASSWORD" ]; do
		printf "\033[1;38;2;0;255;255m\n"
		printf "Enter your \033[38;2;255;0;0mpassword\033[38;2;0;255;255m:\n"
		printf "\033[1;38;2;255;0;128m"
		read -s PASSWORD
		if [ -z "$PASSWORD" ]; then
			printf "\033[1;38;2;255;0;0m"
			printf "Password cannot be empty, please enter it.\n"
		fi
	done

	printf "\n\033[1;38;2;0;255;255m"
	printf "Enter your some email \033[0m"
	printf "(\033[1;38;2;255;255;0mnot necessary\033[0m)\033[1;38;2;0;255;255m:\n"
	printf "\033[1;38;2;255;0;0m"
	printf "!!! I highly recommended entering real mail from "
	printf "\033[1;38;2;0;255;0mGITEA"
	printf "\033[1;38;2;255;0;0m"
	printf " !!!\n"
	printf "\033[1;38;2;255;0;128m"
	read EMAIL
	if [ -z "$EMAIL" ]; then
		EMAIL="silentbob@mail.com"
	fi
	printf "\033[0m"
}

#                                                                                        |
# ---------------------------------------------------------------------------------------|
#                                                                                        |

prepare_memory_repository() {

	FINAL_URL="https://$LOGIN:$PASSWORD@${SAVE_URL#https://}"

	rm -rf /tmp/$LOGIN
	git clone $FINAL_URL /tmp/$LOGIN

	if [ $? -ne 0 ]; then
		printf "\n\033[1;38;2;255;0;0mERROR\033[0m\n\n"
		exit 1
	fi

	cp -f $SCRIPT_DIR/templates/* /tmp/$LOGIN

	sed -i '' "s|<user url>|$SAVE_URL|g" /tmp/$LOGIN/README.md
	sed -i '' "s|<user>|$LOGIN|g" /tmp/$LOGIN/README.md
	sed -i '' "s|<email>|$EMAIL|g" /tmp/$LOGIN/deploy.sh
	sed -i '' "s|<user>|$LOGIN|g" /tmp/$LOGIN/deploy.sh
	sed -i '' "s|<user>|$LOGIN|g" /tmp/$LOGIN/save.sh
	sed -i '' "s|<user>|$LOGIN|g" /tmp/$LOGIN/lis.sh

	cd /tmp/$LOGIN

	./deploy.sh
	./save.sh

	if [ $? -ne 0 ]; then
		printf "\n\033[1;38;2;255;0;0mERROR\033[0m\n\n"
		exit 1
	fi
}

# _______________________________________________________________________________MAIN CODE

set_cleaner
get_variables
prepare_memory_repository

printf "\n\033[1;38;2;0;255;0mLIS has been installed\033[0m\n\n"
exit 0
