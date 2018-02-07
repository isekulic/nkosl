#!/bin/bash

umount /mnt/nkosl
lvremove /dev/nkosl/file
vgremove nkosl