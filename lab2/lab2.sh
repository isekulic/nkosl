#!/bin/bash

if (( $1 < 1 )) || (( $1 > 100 )); then
    echo "Number is not in range [1,100]"
    exit
fi

sudo $(echo lsblk -io NAME,FSTYPE) | awk 'NR>2' | sed 's/[\|`-]//g' > partitions.txt

# problem kod awka - jedan stupac je 6, a drugi 7 
# sudo fdisk -l | awk '{print $1, $6}' | awk 'NR>9'

# dohvaćanje URLa
sudo curl --silent en.wikipedia.org/wiki/$1"_(number)" -o "$1"

# kreiranje .iso
sudo mkdir /mnt/my_iso_directory
sudo cp partitions.txt /mnt/my_iso_directory
sudo cp $1 /mnt/my_iso_directory

sudo mkisofs -o DEVEDE-$1.iso /mnt/my_iso_directory

sudo rm -r /mnt/my_iso_directory
sudo rm $1
sudo rm partitions.txt
