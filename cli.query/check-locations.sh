#!/bin/bash
source ./color-logic.sh
echo "${white} Checking Locations for new Entries ... ${reset}"

az account list-locations --output tsv | awk 'BEGIN { FS = "[\t]+" } ; { print $5 }' > new-locations.lst
DIFF=$(diff locations.lst new-locations.lst)
if [ -z "$DIFF" ]
then
  echo "${white}RESULT:${green} No differences in locations. ${reset}"
else
  echoerr "${white}RESULT:${red} Location differences found.${reset}"
  echoerr $DIFF 
fi
