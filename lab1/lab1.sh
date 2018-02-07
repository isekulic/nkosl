#!/bin/bash

# uptime - skuži sed
echo "uptime:" `uptime | sed 's/.*up \([^,]*\), .*/\1/'`        # može se i s cut

# kernel version (release)
echo "kernel:" `uname -r` 

# model procesora
echo "proc:" `head -5 /proc/cpuinfo | grep "model name" | cut -d : -f 2-`    
#-fields = 2 (od drugog polja nakon što ga presječe po -d)

# količina rama
echo "RAM:" `free -tm | head -2 | tail -1 | cut -d " " -f 11`

# /proc/meminfo | grep "SwapTotal:"
echo "swap:" `free -tm | head -4 | tail -1 | cut -d " " -f 11`

# broj hardova
echo "disks:" `lsblk -io TYPE | grep -c "disk"`

# radi samo kod mene vjerojatno
echo " | 1:" `hdparm -i /dev/sda | grep -i model | cut -d = -f 2 | cut -d , -f 1 & df -h --total | sed -n 9p | awk '{print $2}'`

# model grafičke kartice
echo "video:" `lspci | grep "3D controller" | cut -d : -f 3-`