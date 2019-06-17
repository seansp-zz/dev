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
    echo "${green} Latest Version ${white}$(cat $PROVIDER.$SKU.$LOCATION.lst | cut -f4)${reset}"
  else
    echo "${red} New Version Found ${green} $(cat new-$PROVIDER.$SKU.$LOCATION.lst | cut -f4) ${white} > ${red} $(cat $PROVIDER.$SKU.$LOCATION.lst | cut -f4) ${reset}"
    echoerr "${red}$DIFF${reset}"
  fi 
done <locations.lst
