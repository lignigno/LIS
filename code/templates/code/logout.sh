#!/bin/bash

LIS_SCRIPTS_DIR="/tmp/<user>/code"

$LIS_SCRIPTS_DIR/save.sh
osascript -e 'tell application "System Events" to log out'
