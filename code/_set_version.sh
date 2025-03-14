#!/bin/bash

# <global_update>.<author>.<mini_update>.<tic_counts>
# 
# <global_update>
# увеличивается тимлидом при необходиости перед глобальным обновлением
# если увеличилось обнулить <mini_update> и <tic_counts>
# 
# <author>
# подпись
# 
# <mini_update>
# если с пушем :
# - поправил оформление
# - были какие-то сподвижки по коду
# увеличить число на 1 и обнулить <tic_counts>
# 
# <tic_counts>
# увеличивать после каждого запуска или пуша

LIS_VERSION="0.lignigno.1.1"
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
