#!/bin/bash

LIS_SAVE_URL=""
LIS_LOGIN=""
LIS_PASSWORD=""
LIS_EMAIL=""
LIS_SCRIPT_DIR=$(dirname "$(realpath "$0")")

# ___________________________________________________________________________SUB FUNCTIONS

get_variables() {
	printf "\033[1;38;2;0;255;255m\n"
	printf "1) Create new repository in your "
	printf "\033[1;38;2;0;255;0mGITEA"
	printf " \033[0m(\033[1;38;2;255;255;0mContinue when created\033[0m)"
	read

	while [ -z "$LIS_SAVE_URL" ]; do
		printf "\033[1;38;2;0;255;255m\n"
		printf "2) Enter your repository link:\n"
		printf "\033[1;38;2;255;0;128m"
		read LIS_SAVE_URL
		if [ -z "$LIS_SAVE_URL" ]; then
			printf "\033[1;38;2;255;0;0m"
			printf "Repository link cannot be empty, please enter it.\n"
		fi
	done

	while [ -z "$LIS_LOGIN" ]; do
		printf "\033[1;38;2;0;255;255m\n"
		printf "3) Enter your \033[38;2;0;255;0mlogin\033[38;2;0;255;255m:\n"
		printf "\033[1;38;2;255;0;128m"
		read LIS_LOGIN
		if [ -z "$LIS_LOGIN" ]; then
			printf "\033[1;38;2;255;0;0m"
			printf "Login cannot be empty, please enter it.\n"
		fi
	done

	while [ -z "$LIS_PASSWORD" ]; do
		printf "\033[1;38;2;0;255;255m\n"
		printf "4) Enter your \033[38;2;255;0;0mpassword\033[38;2;0;255;255m:\n"
		printf "\033[1;38;2;255;0;128m"
		read -s LIS_PASSWORD
		if [ -z "$LIS_PASSWORD" ]; then
			printf "\033[1;38;2;255;0;0m"
			printf "Password cannot be empty, please enter it.\n"
		fi
	done

	printf "\n\033[1;38;2;0;255;255m"
	printf "5) Enter your some email \033[0m"
	printf "(\033[1;38;2;255;255;0mnot necessary\033[0m)\033[1;38;2;0;255;255m:\n"
	printf "\033[1;38;2;255;0;0m"
	printf "!!! I highly recommended entering real email from "
	printf "\033[1;38;2;0;255;0mGITEA"
	printf "\033[1;38;2;255;0;0m"
	printf " !!!\n"
	printf "\033[1;38;2;255;0;128m"
	read LIS_EMAIL
	if [ -z "$LIS_EMAIL" ]; then
		LIS_EMAIL="silentbob@mail.com"
	fi
	printf "\033[0m"
}

#                                                                                        |
# ---------------------------------------------------------------------------------------|
#                                                                                        |

prepare_memory_repository() {
	FINAL_URL="https://$LIS_LOGIN:$LIS_PASSWORD@${LIS_SAVE_URL#https://}"

	rm -rf /tmp/$LIS_LOGIN
	git clone $FINAL_URL /tmp/$LIS_LOGIN

	if [ $? -ne 0 ]; then
		printf "\n\033[1;38;2;255;0;0mERROR\033[0m\n\n"
		exit 1
	fi

	cd /tmp/$LIS_LOGIN
	rm -rf $(ls -Ap /tmp/$LIS_LOGIN | grep -v '.git/')

	cd $LIS_SCRIPT_DIR/templates
	echo $(ls -A) /tmp/$LIS_LOGIN | xargs cp -rf

	sed -i '' "s|<user url>|$LIS_SAVE_URL|g" /tmp/$LIS_LOGIN/README.md
	sed -i '' "s|<user>|$LIS_LOGIN|g"        /tmp/$LIS_LOGIN/README.md
	sed -i '' "s|<user>|$LIS_LOGIN|g"        /tmp/$LIS_LOGIN/code/deploy.sh
	sed -i '' "s|<user>|$LIS_LOGIN|g"        /tmp/$LIS_LOGIN/code/help.sh
	sed -i '' "s|<user>|$LIS_LOGIN|g"        /tmp/$LIS_LOGIN/code/lis.sh
	sed -i '' "s|<email>|$LIS_EMAIL|g"       /tmp/$LIS_LOGIN/code/save.sh
	sed -i '' "s|<user>|$LIS_LOGIN|g"        /tmp/$LIS_LOGIN/code/save.sh
	sed -i '' "s|<email>|$LIS_EMAIL|g"       /tmp/$LIS_LOGIN/code/update.sh
	sed -i '' "s|<user>|$LIS_LOGIN|g"        /tmp/$LIS_LOGIN/code/update.sh

	/tmp/$LIS_LOGIN/code/deploy.sh
	/tmp/$LIS_LOGIN/code/save.sh

	if [ $? -ne 0 ]; then
		printf "\n\033[1;38;2;255;0;0mERROR\033[0m\n\n"
		exit 1
	fi
}

# _______________________________________________________________________________MAIN CODE

cd $LIS_SCRIPT_DIR
LIS_REP=$(git rev-parse --show-toplevel)
trap 'rm -rf "$LIS_REP"' EXIT

get_variables
prepare_memory_repository

printf "\033[1;38;2;0;255;0mLIS has been installed\033[0m\n\n"
exit 0
