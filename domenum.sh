#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Usage:"
    echo "bash domenum.sh wildcards_file"
else
    cat $1 | assetfinder --subs-only | anew domains && cat domains | httprobe -c 50 --prefer-https | anew hosts && cat hosts | fff -d 1 -S -o roots && cat roots/*/*.headers | grep -i "Location:" | sort -u | grep -F -f $1 | cut -d ':' -f3 | cut -d '/' -f3 | anew domains
fi
