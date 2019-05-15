#!/bin/bash
source ./color-logic.sh
[ "$#" -eq 2 ] || die "2 arguments required... $#"
PROVIDER=$1
SKU=$2
LOCATION="westus"

echo "${white} Updating $SKU for $PROVIDER  ... ${reset}"
while read LOCATION; do
  echo "${white} Reading details for : ${cyan}$LOCATION${reset}"
  az vm image list --all --publisher $PROVIDER --sku $SKU -o tsv --location $LOCATION | tail -1 > $PROVIDER.$SKU.$LOCATION.lst
done <locations.lst
