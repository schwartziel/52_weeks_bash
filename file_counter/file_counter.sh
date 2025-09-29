#!/bin/bash
set +x

helpmsg="Usage:
  $0 -d <directory>   Count the files in <directory>
  $0                  Show this help message
"

# Show help if no args
if [ $# -eq 0 ]; then
    printf "%s" "$helpmsg"
    exit 0
fi

if [ "$1" != "-d" ]; then
    echo "please use -d to specify the directory."
    printf "%s" "$helpmsg"
    exit 1
fi

directory=$2
if [ -d "$directory" ]; then
    echo "Counting the files in $directory ..."
    num_files=$(find "$directory" -type f | wc -l)
    echo "There are $num_files files in $directory."
else
    echo "Error: $directory is not a valid directory."
    exit 1
fi
