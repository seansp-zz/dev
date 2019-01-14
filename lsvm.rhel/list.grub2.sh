#!/bin/bash
awk -F\' '$1=="menuentry " {print i++ " : " $2}' /boot/efi/EFI/grub2.cfg
