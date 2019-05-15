#!/bin/bash
source ./color-logic.sh
[ "$#" -eq 2 ] || die "2 arguments required... $#"
PROVIDER=$1
SKU=$2

echo "${white} Checking ${cyan}$SKU ${white}for ${cyan}$PROVIDER  ${white}... ${reset}"
while read LOCATION; do
  echo -ne "${white} Reading details for : ${cyan}$LOCATION${reset}"
  az vm image list --all --publisher $PROVIDER --sku $SKU -o tsv --location $LOCATION | tail -1 > new-$PROVIDER.$SKU.$LOCATION.lst
  DIFF=$(diff new-$PROVIDER.$SKU.$LOCATION.lst $PROVIDER.$SKU.$LOCATION.lst)
  if [ -z "$DIFF" ]
  then
    echo "${green} No differences ${reset}"
  else
    echo "${red} Difference Found ${reset}"
    echo "${red} $(cat $PROVIDER.$SKU.$LOCATION.lst)"
    echo "${green} $(cat new-$PROVIDER.$SKU.$LOCATION.lst)"
    echoerr "${white} Delta found in $LOCATION ${reset}"
    echoerr "${red}$DIFF${reset}"
  fi 
done <locations.lst
