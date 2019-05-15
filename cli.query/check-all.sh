#!/bin/bash
source ./color-logic.sh
#./update-locations.sh
"" > all-errors.txt
#./update-provider-sku.sh Canonical 12.04.3-LTS
#./update-provider-sku.sh Canonical 12.04.4-LTS
#./update-provider-sku.sh Canonical 12.04.5-LTS
#./update-provider-sku.sh Canonical 14.04.0-LTS
#./update-provider-sku.sh Canonical 14.04.1-LTS
#./update-provider-sku.sh Canonical 14.04.2-LTS
#./update-provider-sku.sh Canonical 14.04.3-LTS
#./update-provider-sku.sh Canonical 14.04.4-LTS
./check-provider-sku.sh Canonical 14.04.5-DAILY-LTS 2>>all-errors.txt
./check-provider-sku.sh Canonical 14.04.5-LTS 2>>all-errors.txt
#./update-provider-sku.sh Canonical 16
./check-provider-sku.sh Canonical 16.04-DAILY-LTS 2>>all-errors.txt
./check-provider-sku.sh Canonical 16.04-LTS 2>>all-errors.txt
#./update-provider-sku.sh Canonical 16.04.0-LTS 
./check-provider-sku.sh Canonical 18.04-DAILY-LTS 2>>all-errors.txt
./check-provider-sku.sh Canonical 18.04-LTS 2>>all-errors.txt
./check-provider-sku.sh Canonical 18.10 2>>all-errors.txt
./check-provider-sku.sh Canonical 18.10-DAILY 2>>all-errors.txt
./check-provider-sku.sh Canonical 19.04 2>>all-errors.txt
./check-provider-sku.sh Canonical 19.04-DAILY 2>>all-errors.txt
./check-provider-sku.sh Canonical 19.10-DAILY 2>>all-errors.txt

rm new-*

ERRORS=$(cat all-errors.txt)
if [ -z "$ERRORS" ]
then
  echo "${green} No new images. ${reset}"
else
  echo "${red} New Images Detected. ${reset}"
  die $ERRORS
fi
