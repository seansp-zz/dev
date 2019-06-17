#!/bin/bash
source ./color-logic.sh

ERRORFILE=./all-errors.txt
if test -f "$ERRORFILE"; then
  echo "Deleting previous errors."
  rm $ERRORFILE
fi

./check-provider-sku.sh Canonical 16.04-LTS 2>>all-errors.txt
./check-provider-sku.sh Canonical 16.04.0-LTS 2>>all-errors.txt
./check-provider-sku.sh Canonical 18.04-LTS 2>>all-errors.txt

#rm new-*

ERRORS=$(cat $ERRORFILE)
if [ -z "$ERRORS" ]
then
  echo "${green} No new images. ${reset}"
  rm $ERRORFILE
else
  echo "${red} New Images Detected. ${reset}"
  rm $ERRORFILE
  exit 4
fi
