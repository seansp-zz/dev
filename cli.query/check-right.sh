#!/bin/bash
ERRORFILE=./all-errors.txt
if test -f "$ERRORFILE"; then
  echo "Deleting previous errors."
  rm $ERRORFILE
fi

ANYERRORS=0
TOTALCHECKS=0

performTest()
{
  ((TOTALCHECKS++))
  ./check-provider-sku.sh $1 $2
  if [ $? -ne 0 ]; then
    echo "ALERT: New version detected for $2."
    ((ANYERRORS++))
  fi
}

performTest Canonical 14.04.1-LTS
performTest Canonical 14.04.2-LTS
performTest Canonical 14.04.3-LTS
performTest Canonical 14.04.4-LTS
performTest Canonical 14.04.5-LTS
performTest Canonical 16.04-LTS
performTest Canonical 16.04.0-LTS
performTest Canonical 18.04-LTS

echo "$TOTALCHECKS images checked. Any Errors = $ANYERRORS"
if [ $ANYERRORS -ne 0 ]; then
  echo "Errors were encountered."
  exit 4
else
  echo "All images up to date."
fi
