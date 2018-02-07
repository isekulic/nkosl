#!/bin/bash

br_blokova=$(du -B 25M $1 | sed 's/\(^[0-9]*\).*/\1/')
br_blokova=$((br_blokova))+1

#stvaranje prvog loopback uredaja i pva
dd if=/dev/zero bs=4k count=6400 of=disk0.vol
losetup /dev/loop0 disk0.vol
pvcreate /dev/loop0
vgcreate nkosl /dev/loop0

#stvaranje ostalih loopback uredaja i pva
for (( i = 1; i <$((br_blokova)); i++ )); do
	dd if=/dev/zero bs=4k count=6400 of=disk$((i)).vol
	losetup /dev/loop$((i)) disk$((i)).vol
	pvcreate /dev/loop$((i))
	vgextend nkosl /dev/loop$((i))
done

#stvaranje i mountanje lva
mkdir /mnt/nkosl
lvcreate -l 100%VG nkosl -n datoteka
mkfs -t ext4 /dev/nkosl/datoteka
mount /dev/nkosl/datoteka /mnt/nkosl

cp -r $1 /mnt/nkosl
echo "Direktorij "$1" ima $(du -B 1M $1 | sed 's/\(^[0-9]*\).*/\1/') MB."
echo "Broj loopback uredaja: $((br_blokova))"
for (( i = 0; i <$((br_blokova)); i++ )); do
	echo "	disk$((i)).vol"
done
