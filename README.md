# The Kernel Detective: Bash Globbing Mastery

> An exploration of the Linux kernel source using Bash glob patterns, from basic wildcards to advanced pattern matching.

[![Bash](https://img.shields.io/badge/Bash-5.0+-4EAA25?logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Linux Kernel](https://img.shields.io/badge/Linux_Kernel-6.x-FCC624?logo=linux&logoColor=black)](https://kernel.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 🔍 About

This project analyzes one of the largest, most influential codebases in history, **the Linux kernel**, using Bash globbing patterns. Through pattern matching techniques, we uncover insights hidden in 30+ years of code.

## 🎯 Skills Demonstrated

| Category | Patterns Learned |
|----------|------------------|
| **Basic Wildcards** | `*`, `?`, `*/` |
| **Character Classes** | `[0-9]`, `[A-Z]`, `[a-z]`, `[!...]` |
| **Brace Expansion** | `{a,b,c}`, `{1..10}` |
| **Extended Globbing** | `!(pattern)`, `@(a\|b)` |
| **Recursive Matching** | `**/*.c` (globstar) |
| **Shell Options** | `extglob`, `globstar`, `nullglob` |

## 📊 Key Discoveries

| Insight | Finding |
|---------|---------|
| **Top-level structure** | 24 directories, 7 files |
| **Block subsystem** | 56 `.c` files, 16 `.h` files (3.5:1 ratio) |
| **Crypto naming** | 145 lowercase, 2 uppercase, 1 numeric (`842.c`) |
| **Architecture code** | ARM: 655, x86: 599, arm64: 201, riscv: 139 |
| **Non-code files** | block/: 4, crypto/: 10 |

## 📁 Project Structure

```text
project-00.4-bash-globbing/
├── README.md           # This file
├── investigate.sh      # Main analysis script
├── report.txt          # Generated analysis report
└── linux/              # (not tracked) Kernel source for analysis
```

## 🚀 Quick Start

```bash
# Clone the project
git clone https://github.com/rizvawn/bash-globbing.git
cd bash-globbing

# Clone the Linux kernel (shallow clone)
git clone --depth 1 https://github.com/torvalds/linux.git

# Run the investigation
./investigate.sh

# View the report
cat report.txt
```

## 📚 Glob Patterns Quick Reference

### Basic Wildcards

```bash
*           # Match any characters (zero or more)
?           # Match exactly ONE character
*/          # Match directories only
```

### Character Classes

```bash
[abc]       # Match one of a, b, or c
[0-9]       # Match any digit
[A-Z]       # Match uppercase letters
[!0-9]      # Match anything EXCEPT digits
```

### Brace Expansion (generates strings, not matching)

```bash
{a,b,c}     # Expands to: a b c
{1..5}      # Expands to: 1 2 3 4 5
*.{c,h}     # Expands to: *.c *.h
```

### Extended Globbing (requires `shopt -s extglob`)

```bash
!(pattern)  # Match anything EXCEPT pattern
@(a|b)      # Match exactly one of a or b
*(pattern)  # Match zero or more of pattern
+(pattern)  # Match one or more of pattern
```

### Recursive Matching (requires `shopt -s globstar`)

```bash
**/*.c      # All .c files at any depth
**/Makefile # All Makefiles recursively
```

## 🔧 Shell Options Used

```bash
shopt -s extglob   # Enable !(pattern), @(a|b), etc.
shopt -s globstar  # Enable ** for recursive matching
shopt -s nullglob  # Return empty if no matches (not literal pattern)
```

## 📝 Sample Output

```text
=== LINUX KERNEL SOURCE ANALYSIS ===

[Surface Overview]
Directories: 24
Files: 7

[Block Subsystem Analysis]
Number of implementation files: 56
Number of headers files: 16
The ratio between implementation and headers files is 3:1

[Architecture Comparison]
Number of .c files for x86 (Intel/AMD): 599
Number of .c files for arm (32-bit): 655
Number of .c files for arm64 (64-bit): 201
Number of .c files for riscv (emerging): 139

[Non-Code Files Analysis]
Number of non-code files in linux/block/: 4
Number of non-code files in linux/crypto/: 10
```

## 🎓 Learning Journey

This project was completed as part of a Socratic learning approach:

1. **Phase 1**: Basic wildcards (`*`, `?`, `*/`)
2. **Phase 2**: Character classes (`[0-9]`, `[A-Z]`)
3. **Phase 3**: Brace expansion (`{a,b,c}`)
4. **Phase 4**: Extended globbing (`!(pattern)`, `**/*.c`)
5. **Phase 5**: Kernel insights report

See [.github/ROADMAP.md](.github/ROADMAP.md) for the complete learning path.

## 🤝 Contributing

Feel free to fork and extend the analysis! Some ideas:

- Add more kernel subsystems to analyze
- Compare different kernel versions
- Visualize the data with charts

## 📄 License

MIT License - See [LICENSE](LICENSE) for details.

---

***Completed: November 30, 2025***
