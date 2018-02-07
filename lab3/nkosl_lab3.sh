#!/bin/bash

br_blokova=$(du -B 25M $1 | cut -f 1)
br_blokova=$((br_blokova))

dd if=/dev/zero bs=4k count=6400 of=disk0.vol
losetup /dev/loop1 disk0.vol
pvcreate /dev/loop1
vgcreate nkosl /dev/loop1
if [[ br_blokova > 1 ]]; then
    for (( i = 2; i <=$((br_blokova)); i++ )); do
        dd if=/dev/zero bs=4k count=6400 of=disk$((i)).vol
        losetup /dev/loop$((i)) disk$((i)).vol
        pvcreate /dev/loop$((i))
        vgextend nkosl /dev/loop$((i))
    done
fi


mkdir /mnt/nkosl
lvcreate -l 100%VG nkosl -n file
mkfs -t ext4 /dev/nkosl/file
mount /dev/nkosl/file /mnt/nkosl

cp -r $1 /mnt/nkosl
echo "Direktorij "$1" ima $(du -B 1M $1 | cut -f 1) MB."
echo "Broj loopback uredaja: $((br_blokova))"
for (( i = 0; i <$((br_blokova)); i++ )); do
    echo "  disk$((i)).vol"
done
