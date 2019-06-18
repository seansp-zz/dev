#!/bin/bash
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
  echo "No new images."
  rm $ERRORFILE
else
  echo "ALERT: New Images Detected."
  echo "$ERRORS"
  rm $ERRORFILE
  exit 4
fi
