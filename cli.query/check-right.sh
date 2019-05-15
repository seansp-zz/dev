#!/bin/bash
source ./color-logic.sh
#./update-locations.sh
"" > all-errors.txt
./check-provider-sku.sh Canonical 16.04-LTS 2>>all-errors.txt
./check-provider-sku.sh Canonical 16.04.0-LTS 2>>all-errors.txt
./check-provider-sku.sh Canonical 18.04-LTS 2>>all-errors.txt

rm new-*

ERRORS=$(cat all-errors.txt)
if [ -z "$ERRORS" ]
then
  echo "${green} No new images. ${reset}"
else
  echo "${red} New Images Detected. ${reset}"
  die $ERRORS
fi
