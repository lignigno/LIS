#!/bin/bash

LIS_PROJECT_DIR="/tmp/<user>"

$LIS_PROJECT_DIR/code/save.sh
rm -rf $LIS_PROJECT_DIR
osascript -e 'tell application "System Events" to log out'
