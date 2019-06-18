#!/bin/bash
[ "$#" -eq 2 ] || die "2 arguments required... $#"
PROVIDER=$1
SKU=$2

echoerr() { printf "%s\n" "$*" >&2; }

echo "Checking [$SKU] for $PROVIDER ..."
while read LOCATION; do
  echo -ne " Reading details for : $LOCATION ... "
  az vm image list --all --publisher $PROVIDER --sku $SKU -o tsv --location $LOCATION | tail -1 > new-$PROVIDER.$SKU.$LOCATION.lst
  DIFF=$(diff new-$PROVIDER.$SKU.$LOCATION.lst $PROVIDER.$SKU.$LOCATION.lst)
  if [ -z "$DIFF" ]
  then
    echo " Latest -- [$(cat $PROVIDER.$SKU.$LOCATION.lst | cut -f4)]"
  else
    NEWVER="$(cat new-$PROVIDER.$SKU.$LOCATION.lst | cut -f4)"
    OLDVER="$(cat $PROVIDER.$SKU.$LOCATION.lst | cut -f4)"
    RESULT="$NEWVER is more recent that $OLDVER"
    echo $RESULT
    echoerr $RESULT
    exit 4
  fi 
done <locations.lst
