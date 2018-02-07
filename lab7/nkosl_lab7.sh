#!/bin/bash

if [[ $1 == 'install' ]]; then
    git clone https://github.com/lxc/lxc
    #git checkout $2
    cd lxc && ./autogen.sh && ./configure && make && sudo make install
fi

if [[ $1 == 'start' ]]; then
    shift
    while [[ $1 != '' ]]; do
        if [[ $(lxc-ls | grep -c $1) -ne 1 ]]; then
            lxc-create -t ubuntu -n $1 
        fi
        lxc-start -d -n $1  
        shift
    done
fi



if [[ $1 == 'stop' ]]; then
    shift
    while [[ $1 != '' ]]; do
        lxc-stop -n $1
        shift
    done
fi

if [[ $1 == 'uninstall' ]]; then
    lxc-ls -1 | while read line; do
        lxc-stop -n $line
        lxc-destroy -n $line
    done
    cd lxc && make uninstall
    cd .. && rm -r lxc
fi
