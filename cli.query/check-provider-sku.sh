#!/bin/bash
[ "$#" -eq 2 ] || die "2 arguments required... $#"
PROVIDER=$1
SKU=$2

echo "Checking [$SKU] for $PROVIDER ..."
while read LOCATION; do
  echo -ne " Reading details for : $LOCATION ... "
  az vm image list --all --publisher $PROVIDER --sku $SKU -o tsv --location $LOCATION | tail -1 > new-$PROVIDER.$SKU.$LOCATION.lst
  DIFF=$(diff new-$PROVIDER.$SKU.$LOCATION.lst $PROVIDER.$SKU.$LOCATION.lst)
  if [ -z "$DIFF" ]
  then
    echo " Latest -- [$(cat $PROVIDER.$SKU.$LOCATION.lst | cut -f4)]"
  else
    echo "ALERT: New Version Found [$(cat new-$PROVIDER.$SKU.$LOCATION.lst | cut -f4)] is more recent than [$(cat $PROVIDER.$SKU.$LOCATION.lst | cut -f4)]"
    echo "$DIFF"
  fi 
done <locations.lst
