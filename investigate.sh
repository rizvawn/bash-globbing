#!/bin/bash

echo "=== LINUX KERNEL SOURCE ANALYSIS ===" > report.txt

report() {
    echo "$1" >> report.txt 
}

report "Generated: $(date +%Y-%m-%d)"
report "*************************************
"

#########################################################

DIR_COUNT_LS="$(ls -l linux/ | grep "^d" | wc -l)"
FILE_COUNT_LS="$(ls -l linux/ | grep "^-" | wc -l)"

echo "
[Surface Overview]
"

echo "Using ls:   
Directories: $DIR_COUNT_LS, Files: $FILE_COUNT_LS
**************"

DIRECTORIES=(linux/*/)
ALL=(linux/*)

DIR_COUNT=${#DIRECTORIES[@]} 
ALL_COUNT=${#ALL[@]} 
FILE_COUNT=$(( ALL_COUNT - DIR_COUNT ))

echo "Using glob: 
Directories: $DIR_COUNT, Files: $FILE_COUNT
***************"

report "[Surface Overview]
"
report "Directories: $DIR_COUNT"
report "Files: $FILE_COUNT"
report "
*****************
"

########################################################

C_FILES_LS="$(ls linux/block/*.c | wc -l)"
H_FILES_LS="$(ls linux/block/*.h | wc -l)"

echo "
[Block Subsystem Analysis]
"
echo "Using ls:   
Number of implementation files: ${C_FILES_LS}
Number of headers files: ${H_FILES_LS}
***************"

C_FILES=(linux/block/*.c)
H_FILES=(linux/block/*.h)

C_FILES_COUNT=${#C_FILES[@]}
H_FILES_COUNT=${#H_FILES[@]}
RATIO=$((C_FILES_COUNT / H_FILES_COUNT))

echo "Using glob:
Number of implementation files: ${C_FILES_COUNT}
Number of headers files: ${H_FILES_COUNT}
The ration between implementation and headers files is ${RATIO}:1
**************"
echo ""

report "[Block Subsystem Analysis]
"
report "Number of implementation files: ${C_FILES_COUNT}"
report "Number of headers files: ${H_FILES_COUNT}"
report "The ratio between implementation and headers files is ${RATIO}:1"
report "
****************
"

########################################################

FILENAMES_STARTING_WITH_NUMBER=(linux/crypto/[0-9]*) #FSW_NUMBER
FILENAMES_STARTING_WITH_UPPERCASE=(linux/crypto/[A-Z]*) #FSW_UPPERCASE
FILENAMES_STARTING_WITH_LOWERCASE=(linux/crypto/[a-z]*) #FSW_LOWERCASE

COUNT_FSW_NUMBER=${#FILENAMES_STARTING_WITH_NUMBER[@]}
COUNT_FSW_UPPERCASE=${#FILENAMES_STARTING_WITH_UPPERCASE[@]}
COUNT_FSW_LOWERCASE=${#FILENAMES_STARTING_WITH_LOWERCASE[@]}

echo "[Crypto Naming Patterns]
Number of files starting with a number: ${COUNT_FSW_NUMBER}
e.g. ${FILENAMES_STARTING_WITH_NUMBER[0]}
Number of files starting with an uppercase letter: ${COUNT_FSW_UPPERCASE}
e.g. ${FILENAMES_STARTING_WITH_UPPERCASE[0]}
Number of files starting with an lowercase letter: ${COUNT_FSW_LOWERCASE}
e.g. ${FILENAMES_STARTING_WITH_LOWERCASE[0]}

*learnt*: Linux kernel follows conventions:
code files => lowercase
special files => uppercase
****************"

report "[Crypto Naming Patterns]

Number of files starting with a number: ${COUNT_FSW_NUMBER}
e.g. ${FILENAMES_STARTING_WITH_NUMBER[0]}
Number of files starting with an uppercase letter: ${COUNT_FSW_UPPERCASE}
e.g. ${FILENAMES_STARTING_WITH_UPPERCASE[0]}
Number of files starting with an lowercase letter: ${COUNT_FSW_LOWERCASE}
e.g. ${FILENAMES_STARTING_WITH_LOWERCASE[0]}

*learnt*: Linux kernel follows conventions:
code files => lowercase
special files => uppercase

********************
" 

#######################################################