#!/bin/bash
set +x
helpmsg=" -d             specify a directory to count the files in\n ./file-counter.sh              displays this message.  "
# this doesn't work.
if [ ! -n "$0" ]; then
    printf "%s$helpmsg"
fi
if [ "$1" != "-d" ]; then
    echo "please use -d to specify the directory."
else
    directory=$2
    if [ -d "$directory" ]; then
        echo "counting the files in $directory"
        num_files=$(find "$directory" -type f | wc -l)
        echo "There are "$num_files" in $directory"
    fi
fi
