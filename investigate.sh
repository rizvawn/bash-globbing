#!/bin/bash

echo "=== LINUX KERNEL SOURCE ANALYSIS ===" > report.txt

report() {
    echo "$1" >> report.txt 
}

report "Generated: $(date +%Y-%m-%d)"
report ""

#########################################################

report "[Surface Overview]"

DIR_COUNT_LS="$(ls -l linux/ | grep "^d" | wc -l)"
FILE_COUNT_LS="$(ls -l linux/ | grep "^-" | wc -l)"

echo "Using ls:   Directories: $DIR_COUNT_LS, Files: $FILE_COUNT_LS"

DIRECTORIES=(linux/*/)
ALL=(linux/*)

DIR_COUNT=${#DIRECTORIES[@]} 
ALL_COUNT=${#ALL[@]} 
FILE_COUNT=$(( ALL_COUNT - DIR_COUNT ))

echo "Using glob: Directories: $DIR_COUNT, Files: $FILE_COUNT"

report "Directories: $DIR_COUNT"
report "Files: $FILE_COUNT"