#!/bin/bash

LIS_VERSION="0.21"
LIS_TMPL_README="./templates/README.md"
LIS_TMPL_UPDATE="./templates/code/update.sh"
LIS_MAIN_README="../README.md"
LIS_MAIN_UPDATE="./update.sh"
LIS_SCRIPT_DIR=$(dirname "$(realpath "$0")")

# _______________________________________________________________________________MAIN CODE

cd $LIS_SCRIPT_DIR

sed -i '' "s/INSTALLED VERSION : .*/INSTALLED VERSION : $LIS_VERSION/" $LIS_TMPL_README
sed -i '' "s/LIS_VERSION=\"[^\"]*\"/LIS_VERSION=\"$LIS_VERSION\"/" $LIS_TMPL_UPDATE
sed -i '' "s/VERSION : .*/VERSION : $LIS_VERSION/" $LIS_MAIN_README
sed -i '' "s/LIS_VERSION=\"[^\"]*\"/LIS_VERSION=\"$LIS_VERSION\"/" $LIS_MAIN_UPDATE
