#/bin/bash
az vm image list -p Canonical --all -o tsv | awk 'BEGIN { FS = "[\t]+" } ; { print $3 }' | sort | uniq
