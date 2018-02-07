#!/bin/bash

gpg --verify /etc/chksig.conf

if [[ $? -ne 0 ]]; then
     exit 2
fi

grep '^/.*' /etc/chksig.conf | while read line ; do
    path=$(echo "$line" | cut -d ' ' -f 1)
    hash_number=$(echo "$line" | cut -d " " -f 2) 
    check=$(sha1sum $path | cut -d ' ' -f 1)

    if [[ $hash_number != $check ]]; then
        exit 2
    fi 
done

if [[ $? -ne 0 ]]; then
    echo "Greška."
    exit 2
fi

echo "OK"
exit 0