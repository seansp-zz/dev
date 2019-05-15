#!/bin/bash
source ./color-logic.sh
echo "${white} Updating Azure Locations ... ${reset}"
az account list-locations --output tsv | awk 'BEGIN { FS = "[\t]+" } ; { print $5 }' > locations.lst
