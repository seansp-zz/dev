#!/bin/bash

# First, read the current grub cmdline args
cmdline=$(grep "^GRUB_CMDLINE_LINUX=" /etc/default/grub)
echo "## grub CMDLine : ${cmdline}"
if [[ -z "$cmdline" ]]; then
    exit 1
    printf "GRUB_CMDLINE_LINUX=\"\"\n" >> /etc/default/grub
    cmdline=$(grep "^GRUB_CMDLINE_LINUX=" /etc/default/grub)
fi
newcmdline="${cmdline%\"}"
echo "## NewCMDLine: ${newcmdline}"
# Now, read /etc/cryptab  for possible UUIDS
vars=$(awk '{ print $2 }' /etc/crypttab)
for uuid in $vars; do
    if [[ ${uuid:0:4} != "UUID" ]]; then
        # Device name, use BLKID to figure out UUID
        echo "## Using BLKID to find UUID"
        uuid=$(blkid "$uuid" | grep -o "\<UUID=\"[^\"]*\"")
        if [[ -z "$uuid" ]]; then
            echo "Error: device $uuid has no uuid" 1>&2
            exit 1
        fi
        echo "## Found: ${uuid}"
    fi   

    uuid=${uuid:5}
    if [[ "$cmdline" =~ "rd.luks.uuid=$uuid" ]] || [[ "$cmdline" =~ "rd.luks.uuid=luks-$uuid" ]]; then
        # Found the uuid
        continue
    fi

    newcmdline+=" rd.luks.uuid=$uuid"    
done
newcmdline+=\"
echo "## Writing to /etc/default/grub"
sed -i "s#$cmdline#$newcmdline#g" /etc/default/grub
