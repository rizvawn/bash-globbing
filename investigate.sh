#!/bin/bash

echo "
=== LINUX KERNEL SOURCE ANALYSIS ===" | tee report.txt

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
"

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
"

C_FILES=(linux/block/*.c)
H_FILES=(linux/block/*.h)

C_FILES_COUNT=${#C_FILES[@]}
H_FILES_COUNT=${#H_FILES[@]}
RATIO=$((C_FILES_COUNT / H_FILES_COUNT))

echo "Using glob:
Number of implementation files: ${C_FILES_COUNT}
Number of headers files: ${H_FILES_COUNT}
The ratio between implementation and headers files is ${RATIO}:1

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

FILENAMES_STARTING_WITH_NUMBER=(linux/crypto/[0-9]*) 
FILENAMES_STARTING_WITH_UPPERCASE=(linux/crypto/[A-Z]*) 
FILENAMES_STARTING_WITH_LOWERCASE=(linux/crypto/[a-z]*)

COUNT_NUMBER_FILENAMES=${#FILENAMES_STARTING_WITH_NUMBER[@]}
COUNT_UPPERCASE_FILENAMES=${#FILENAMES_STARTING_WITH_UPPERCASE[@]}
COUNT_LOWERCASE_FILENAMES=${#FILENAMES_STARTING_WITH_LOWERCASE[@]}
LEARNT="Linux kernel follows conventions:
code files => lowercase
special files => uppercase"

echo "[Crypto Naming Patterns]

Number of files starting with a number: ${COUNT_NUMBER_FILENAMES}
e.g. ${FILENAMES_STARTING_WITH_NUMBER[0]}

Number of files starting with an uppercase letter: ${COUNT_UPPERCASE_FILENAMES}
e.g. ${FILENAMES_STARTING_WITH_UPPERCASE[0]}

Number of files starting with an lowercase letter: ${COUNT_LOWERCASE_FILENAMES}
e.g. ${FILENAMES_STARTING_WITH_LOWERCASE[0]}

*learnt*: ${LEARNT}

****************"

report "[Crypto Naming Patterns]

Number of files starting with a number: ${COUNT_NUMBER_FILENAMES}
e.g. ${FILENAMES_STARTING_WITH_NUMBER[0]}

Number of files starting with an uppercase letter: ${COUNT_UPPERCASE_FILENAMES}
e.g. ${FILENAMES_STARTING_WITH_UPPERCASE[0]}

Number of files starting with an lowercase letter: ${COUNT_LOWERCASE_FILENAMES}
e.g. ${FILENAMES_STARTING_WITH_LOWERCASE[0]}

*learnt*: ${LEARNT}

********************
" 

#######################################################

shopt -s globstar  
shopt -s nullglob  

ARCH_DIRS=(linux/arch/{x86,arm,arm64,riscv}/)

X86_FILES=(linux/arch/x86/**/*.c)
ARM_FILES=(linux/arch/arm/**/*.c)
ARM64_FILES=(linux/arch/arm64/**/*.c)
RISCV_FILES=(linux/arch/riscv/**/*.c)

X86_COUNT=${#X86_FILES[@]}
ARM_COUNT=${#ARM_FILES[@]}
ARM64_COUNT=${#ARM64_FILES[@]}
RISCV_COUNT=${#RISCV_FILES[@]}

NONEXISTENT=(linux/arch/x86/**/*.xyz)

LEARNT="ARM has more files for many more device variations 
(phones, Raspberry Pi, embedded systems).

x86 is more standardized (fewer hardware quirks to handle).

RISC-V is open-source, royalty-free and is used in:
Low-power IoT devices
Some NASA projects
SSD manufacturer Western Digital's storage controllers"

echo "
[Architecture Comparison]

Architecture paths analyzed: ${#ARCH_DIRS[@]} 
${ARCH_DIRS[*]}

Number of .xyz files: ${#NONEXISTENT[@]} matches

Number of .c files for x86 (Intel/AMD): ${X86_COUNT}
e.g. ${X86_FILES[0]}

Number of .c files for arm (32-bit): ${ARM_COUNT}
e.g. ${ARM_FILES[0]}

Number of .c files for arm64 (64-bit): ${ARM64_COUNT}
e.g. ${ARM64_FILES[0]}

Number of .c files for riscv (emerging): ${RISCV_COUNT}
e.g. ${RISCV_FILES[0]}

*learnt*: ${LEARNT}

****************
"

report "[Architecture Comparison]

Architecture paths analyzed: ${#ARCH_DIRS[@]} 
${ARCH_DIRS[*]}

Number of .xyz files: ${#NONEXISTENT[@]} matches

Number of .c files for x86 (Intel/AMD): ${X86_COUNT}
e.g. ${X86_FILES[0]}

Number of .c files for arm (32-bit): ${ARM_COUNT}
e.g. ${ARM_FILES[0]}

Number of .c files for arm64 (64-bit): ${ARM64_COUNT}
e.g. ${ARM64_FILES[0]}

Number of .c files for riscv (emerging): ${RISCV_COUNT}
e.g. ${RISCV_FILES[0]}

*learnt*: ${LEARNT}

*********************
"

######################################################

shopt -s extglob

OTHER_FILES_BLOCK=(linux/block/!(*.c|*.h))
OTHER_BLOCK_COUNT=${#OTHER_FILES_BLOCK[@]}
BLOCK_EXAMPLE=${OTHER_FILES_BLOCK[0]}

OTHER_FILES_CRYPTO=(linux/crypto/!(*.c|*.h))
OTHER_CRYPTO_COUNT=${#OTHER_FILES_CRYPTO[@]}
CRYPTO_EXAMPLE=${OTHER_FILES_CRYPTO[0]}

echo "[Non-Code Files Analysis]

Number of non-code files in linux/block/: ${OTHER_BLOCK_COUNT}
e.g. ${BLOCK_EXAMPLE}

Number of non-code files in linux/crypto/: ${OTHER_CRYPTO_COUNT}
e.g. ${CRYPTO_EXAMPLE}

*********************

✅ Analysis complete! See report.txt
"

report "[Non-Code Files Analysis]

Number of non-code files in linux/block/: ${OTHER_BLOCK_COUNT}
e.g. ${BLOCK_EXAMPLE}

Number of non-code files in linux/crypto/: ${OTHER_CRYPTO_COUNT}
e.g. ${CRYPTO_EXAMPLE}

*********************

✅ Analysis complete!
"

