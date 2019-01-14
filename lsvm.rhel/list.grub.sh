#!/bin/bash
awk -F\' '$1=="menuentry " {print i++ " : " $2}' /boot/efi/EFI/redhat/grub.cfg
