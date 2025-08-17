## File Search Commands

### `find` - The Swiss Army Knife of File Searching

**What it does:** Recursively searches directories for files and folders based on various criteria like name, size, date, permissions, etc.

**Basic Syntax:** `find [path] [expression] [action]`

```bash
# Basic file search by name
find . -name "*.py"
# Explanation: Search current directory (.) and subdirectories for files ending in .py

# Case-insensitive search
find . -iname "README*"
# Explanation: -iname ignores case, finds README.md, readme.txt, etc.

# Search by file type
find . -type f -name "*.js"     # Files only
find . -type d -name "node*"    # Directories only
find . -type l                  # Symbolic links only

# Search by size
find . -size +100M              # Files larger than 100MB
find . -size -1k                # Files smaller than 1KB
find . -size 50c                # Files exactly 50 bytes

# Search by modification time
find . -mtime -7                # Modified in last 7 days
find . -mtime +30               # Modified more than 30 days ago
find . -mmin -60                # Modified in last 60 minutes

# Search by permissions
find . -perm 755                # Exactly these permissions
find . -perm -644               # At least these permissions

# Complex searches with logical operators
find . -name "*.py" -and -size +1M
find . -name "*.log" -or -name "*.tmp"
find . -not -name "*.git*"

# Execute commands on found files
find . -name "*.pyc" -delete                    # Delete compiled Python files
find . -name "*.py" -exec wc -l {} \;          # Count lines in each Python file
find . -name "*.py" -exec grep -l "import" {} \; # Find Python files with imports

# Advanced examples
find . -type f -name "*.py" -exec grep -l "class" {} \; | head -10
# Explanation: Find Python files containing "class", show first 10 results

find . -name "*.js" -not -path "*/node_modules/*" -not -path "*/dist/*"
# Explanation: Find JS files but exclude node_modules and dist directories
```

### `grep` - Text Pattern Matching Master

**What it does:** Searches for patterns within files and outputs matching lines. Essential for code analysis and debugging.

**Basic Syntax:** `grep [options] pattern [file...]`

```bash
# Basic pattern search
grep "function" app.js
# Explanation: Find lines containing "function" in app.js

# Case-insensitive search
grep -i "error" logfile.txt
# Explanation: -i flag ignores case (finds Error, ERROR, error, etc.)

# Show line numbers
grep -n "TODO" *.py
# Explanation: -n shows line numbers where matches occur

# Recursive search through directories
grep -r "console.log" src/
# Explanation: -r searches all files in src/ directory and subdirectories

# Count matches instead of showing them
grep -c "import" *.py
# Explanation: -c shows count of matching lines per file

# Show context around matches
grep -C 3 "error" app.py        # 3 lines before and after
grep -A 5 "function" app.js     # 5 lines after match
grep -B 2 "class" app.py        # 2 lines before match

# Whole word matching
grep -w "log" *.js
# Explanation: -w ensures "log" is a complete word (won't match "logger" or "blog")

# Invert match (show non-matching lines)
grep -v "debug" app.py
# Explanation: -v shows lines that DON'T contain "debug"

# Multiple patterns
grep -E "(error|warning|critical)" logfile.txt
# Explanation: -E enables extended regex, | means OR

# Show only filenames with matches
grep -l "class" *.py            # Files that contain "class"
grep -L "test" *.py             # Files that DON'T contain "test"

# Regular expressions
grep "^def " *.py               # Lines starting with "def "
grep "return.*None" *.py        # Lines with "return" followed by "None"
grep "[0-9]\{3\}-[0-9]\{3\}-[0-9]\{4\}" contacts.txt  # Phone numbers

# Practical coding examples
grep -rn "TODO\|FIXME\|HACK" --include="*.py" --include="*.js" .
# Explanation: Find code comments that need attention with line numbers

grep -r "import.*from.*\." --include="*.py" .
# Explanation: Find relative imports in Python

grep -E "console\.(log|error|warn)" --include="*.js" -r src/
# Explanation: Find console statements in JavaScript files
```

## Advanced Text Processing

### `awk` - Pattern-Action Programming Language

**What it does:** Processes text line by line, splitting each line into fields and allowing complex data manipulation.

**Basic Concepts:**
- `$0` = entire line
- `$1, $2, $3...` = first field, second field, third field...
- `NF` = number of fields in current line
- `NR` = current line number

```bash
# Print specific columns
awk '{print $1}' file.txt
# Explanation: Print first column of each line

# Work with CSV files
awk -F',' '{print $2, $4}' data.csv
# Explanation: -F',' sets field separator to comma, prints columns 2 and 4

# Print lines with more than 80 characters
awk 'length > 80' code.py
# Explanation: Built-in length function checks line length

# Print line numbers with content
awk '{print NR ": " $0}' file.txt
# Explanation: NR is line number, $0 is entire line

# Mathematical operations
awk '{sum += $1} END {print sum}' numbers.txt
# Explanation: Sum all numbers in first column, print total at end

# Conditional processing
awk '$3 > 100 {print $1, $2}' data.txt
# Explanation: Print columns 1 and 2 only if column 3 is greater than 100

# String matching
awk '/error/ {print "Line " NR ": " $0}' logfile.txt
# Explanation: Print line number and content for lines containing "error"

# Count occurrences
awk '{count[$1]++} END {for (word in count) print word, count[word]}' file.txt
# Explanation: Count occurrences of each word in first column

# Practical examples for developers
awk -F: '$3 >= 1000 {print $1}' /etc/passwd
# Explanation: Find user accounts with UID >= 1000

ps aux | awk '$3 > 5.0 {print $2, $11}'
# Explanation: Find processes using more than 5% CPU

awk '/^[[:space:]]*$/ {empty++} END {print "Empty lines:", empty+0}' code.py
# Explanation: Count empty lines in a file
```

### `sed` - Stream Editor for Text Transformation

**What it does:** Non-interactive stream editor that can perform basic text transformations on input streams or files.

**Basic Operations:**
- `s` = substitute
- `d` = delete
- `i` = insert
- `a` = append
- `c` = change

```bash
# Basic substitution
sed 's/old/new/' file.txt
# Explanation: Replace first occurrence of "old" with "new" on each line

# Global substitution
sed 's/old/new/g' file.txt
# Explanation: Replace ALL occurrences of "old" with "new" on each line

# Case-insensitive substitution
sed 's/old/new/gi' file.txt
# Explanation: g = global, i = ignore case

# Edit file in-place
sed -i '' 's/old/new/g' file.txt
# Explanation: -i '' modifies the original file (empty string for no backup on macOS)

# Edit with backup
sed -i '.backup' 's/old/new/g' file.txt
# Explanation: Creates file.txt.backup before modifying

# Delete lines
sed '/debug/d' script.py
# Explanation: Delete all lines containing "debug"

sed '1,5d' file.txt
# Explanation: Delete lines 1 through 5

# Insert and append lines
sed '1i\#!/usr/bin/env python3' script.py
# Explanation: Insert shebang line at the beginning

sed '$a\# End of file' script.py
# Explanation: Append comment at end of file ($)

# Print specific lines
sed -n '10,20p' file.txt
# Explanation: -n suppresses default output, p prints lines 10-20

# Multiple operations
sed -e 's/foo/bar/g' -e 's/hello/hi/g' file.txt
# Explanation: Perform multiple substitutions

# Regular expressions
sed 's/[0-9]\+/NUMBER/g' file.txt
# Explanation: Replace sequences of digits with "NUMBER"

# Practical examples
sed 's/^[[:space:]]*//' file.txt
# Explanation: Remove leading whitespace

sed '/^$/d' file.txt
# Explanation: Remove empty lines

sed 's/\t/    /g' file.txt
# Explanation: Replace tabs with 4 spaces
```

## Process Management Deep Dive

### `ps` - Process Status Inspector

**What it does:** Shows information about running processes including PID, CPU usage, memory usage, and command details.

```bash
# Show all processes for all users
ps aux
# Explanation: a = all users, u = user-oriented format, x = include processes without terminal

# Show process hierarchy (tree format)
ps auxf
# Explanation: f = forest (tree) format showing parent-child relationships

# Show processes for current user only
ps ux
# Explanation: Show detailed info for current user's processes

# Custom output format
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu
# Explanation: -e = all processes, -o = custom output format, sort by CPU usage

# Find specific processes
ps aux | grep python
# Explanation: Show all Python processes

ps aux | grep -E "(node|npm|yarn)"
# Explanation: Find Node.js related processes

# Show threads
ps auxm
# Explanation: m = show threads

# Real-time process monitoring (alternative to top)
ps aux --sort=-%cpu | head -20
# Explanation: Show top 20 CPU-consuming processes
```

### `kill` and `killall` - Process Termination

**What it does:** Sends signals to processes to terminate them gracefully or forcefully.

**Common Signals:**
- `TERM` (15) = Graceful termination (default)
- `KILL` (9) = Force kill (cannot be ignored)
- `HUP` (1) = Hangup (reload configuration)
- `INT` (2) = Interrupt (like Ctrl+C)

```bash
# Graceful termination
kill 1234
# Explanation: Send TERM signal to process ID 1234

# Force kill
kill -9 1234
# Explanation: Send KILL signal (cannot be ignored)

# Kill by process name
killall python3
# Explanation: Kill all processes named "python3"

# Kill with specific signal
kill -HUP 1234
# Explanation: Send hangup signal (often reloads config)

# Interactive kill selection
ps aux | grep node
kill $(ps aux | grep 'node server.js' | grep -v grep | awk '{print $2}')
# Explanation: Find and kill specific node process

# Kill processes by pattern
pkill -f "python script.py"
# Explanation: Kill processes matching the full command line

# Kill processes by user
killall -u username
# Explanation: Kill all processes owned by specific user
```

## Network and System Analysis

### `lsof` - List Open Files and Network Connections

**What it does:** Shows which files are open by which processes, including network connections, regular files, and device files.

```bash
# See what's using a specific port
lsof -i :3000
# Explanation: Show processes listening on or connected to port 3000

# See all network connections
lsof -i
# Explanation: Show all network connections (TCP and UDP)

# See TCP connections only
lsof -iTCP
# Explanation: Show only TCP connections

# See connections in LISTEN state
lsof -iTCP -sTCP:LISTEN
# Explanation: Show processes listening for connections

# See files opened by specific process
lsof -p 1234
# Explanation: Show all files opened by process ID 1234

# See files opened by specific program
lsof -c python
# Explanation: Show files opened by processes whose command starts with "python"

# See who's using a specific file
lsof /var/log/system.log
# Explanation: Show which processes have this file open

# See network connections by specific user
lsof -a -u username -i
# Explanation: -a = AND condition, show network connections for specific user

# Continuous monitoring
lsof -r 2 -i :8080
# Explanation: Refresh every 2 seconds, monitor port 8080
```

### `netstat` - Network Statistics

**What it does:** Displays network connections, routing tables, interface statistics, and more.

```bash
# Show all listening ports
netstat -tuln
# Explanation: t = TCP, u = UDP, l = listening, n = numerical addresses

# Show all connections
netstat -tun
# Explanation: Show all TCP and UDP connections

# Show connections with process info
netstat -tulnp
# Explanation: p = show process ID and name

# Show routing table
netstat -rn
# Explanation: r = routing table, n = numerical

# Show interface statistics
netstat -i
# Explanation: Show network interface statistics

# Show multicast group memberships
netstat -g
# Explanation: Show multicast group information
```

## File Operations Enhanced

### Advanced `ls` Usage

```bash
# Long format with human-readable sizes
ls -lah
# Explanation: l = long format, a = include hidden, h = human-readable sizes

# Sort by modification time (newest first)
ls -lt
# Explanation: t = sort by time

# Sort by size (largest first)  
ls -lS
# Explanation: S = sort by size

# Reverse sort order
ls -ltr
# Explanation: r = reverse order (oldest first when combined with t)

# Show inode numbers
ls -li
# Explanation: i = show inode numbers

# Classify file types
ls -F
# Explanation: Add indicators (/ for dirs, * for executables, @ for links)

# One file per line
ls -1
# Explanation: Force one file per line output

# Recursive listing
ls -R
# Explanation: R = recursive (show subdirectories)

# Show only directories
ls -d */
# Explanation: d = directories only, */ = glob pattern for directories

# Custom time format
ls -l --time-style='+%Y-%m-%d %H:%M'
# Explanation: Custom date/time format
```

### `du` - Disk Usage Analysis

**What it does:** Shows disk space usage for directories and files.

```bash
# Human-readable format
du -h
# Explanation: Show sizes in KB, MB, GB instead of bytes

# Summary of current directory
du -sh .
# Explanation: s = summary (total only), h = human-readable

# Show disk usage of subdirectories
du -h --max-depth=1
# Explanation: Limit depth to 1 level (immediate subdirectories only)

# Sort by size
du -h | sort -hr
# Explanation: Sort by human-readable size, largest first

# Exclude certain patterns
du -h --exclude="*.git*" --exclude="node_modules"
# Explanation: Skip .git directories and node_modules

# Show apparent size vs disk usage
du -h --apparent-size
# Explanation: Show file sizes instead of disk usage (useful for sparse files)

# Find largest directories
du -h | sort -hr | head -20
# Explanation: Show 20 largest directories

# Cross-filesystem boundary analysis
du -x -h
# Explanation: x = don't cross filesystem boundaries
```

## Powerful Command Combinations

### Code Analysis Workflows

```bash
# Find all TODO/FIXME comments with context
grep -rn -A 2 -B 1 "TODO\|FIXME\|HACK\|XXX" --include="*.py" --include="*.js" --include="*.java" .
# Explanation: Search multiple file types, show 2 lines after and 1 before each match

# Code statistics by file type
find . -name "*.py" -exec wc -l {} + | awk '{total += $1} END {print "Python lines:", total}'
find . -name "*.js" -exec wc -l {} + | awk '{total += $1} END {print "JavaScript lines:", total}'
# Explanation: Count total lines of code by language

# Find large files that might need optimization
find . -type f -name "*.py" -exec ls -la {} \; | awk '$5 > 10000 {print $9, $5}' | sort -k2 -nr
# Explanation: Find Python files larger than 10KB, sort by size

# Search for potential security issues
grep -rn -E "(password|secret|key).*=" --include="*.py" --include="*.js" . | grep -v "test"
# Explanation: Find variables that might contain sensitive data, exclude test files

# Find duplicate function definitions
grep -rn "^def " --include="*.py" . | awk -F: '{print $3}' | sort | uniq -d
# Explanation: Find duplicate function names across Python files

# Analyze import patterns
grep -rn "^import\|^from.*import" --include="*.py" . | awk -F: '{print $3}' | sort | uniq -c | sort -nr
# Explanation: Find most commonly imported modules
```

### Log Analysis Workflows

```bash
# Real-time log monitoring with filtering
tail -f /var/log/application.log | grep -E "(ERROR|WARN)" --color=always
# Explanation: Follow log file and highlight errors and warnings

# Count error types in logs
grep "ERROR" application.log | awk '{print $4}' | sort | uniq -c | sort -nr
# Explanation: Extract error types and count occurrences

# Find peak traffic times
awk '{print $4}' access.log | cut -d: -f2 | sort | uniq -c | sort -nr | head -10
# Explanation: Extract hours from access log and find busiest times

# Search logs within time range
awk '/2024-01-15 14:00/,/2024-01-15 15:00/' application.log | grep ERROR
# Explanation: Find errors between 2 PM and 3 PM on specific date
```

### System Monitoring Combinations

```bash
# Find processes consuming most memory
ps aux | sort -k4 -nr | head -10
# Explanation: Sort by memory usage (4th column), show top 10

# Monitor specific process over time
while true; do ps aux | grep "python script.py" | grep -v grep; sleep 5; done
# Explanation: Check specific process every 5 seconds

# Find files modified in last hour with details
find . -type f -mmin -60 -exec ls -la {} \; | sort -k6,7
# Explanation: Show recently modified files with timestamps

# Network connection monitoring
watch -n 2 'netstat -tuln | grep :80'
# Explanation: Monitor port 80 connections every 2 seconds

# Disk space monitoring
df -h | awk '$5 > 80 {print $0}' 
# Explanation: Show filesystems more than 80% full
```

## zsh-Specific Power Features

### Globbing (Pattern Matching)

```bash
# Recursive globbing
ls **/*.py                    # All Python files in any subdirectory
rm **/*.pyc                   # Remove all compiled Python files recursively

# Extended globbing
ls *.(py|js|java)            # Files with specific extensions
ls ^*.txt                    # All files EXCEPT .txt files

# Glob qualifiers
ls *(.)                      # Files only (not directories)
ls *(/)                      # Directories only
ls *(.L+10)                  # Files larger than 10MB
ls *(.m-1)                   # Files modified within last day

# Complex patterns
ls **/*test*.(py|js)         # Test files in any subdirectory
ls **/*(.)(.x)               # Executable files recursively
```

### History and Completion

```bash
# History search and substitution
!!                           # Repeat last command
!-2                          # Repeat command from 2 commands ago
!grep                        # Repeat last command starting with "grep"
^old^new                     # Replace "old" with "new" in last command

# History with grep
history | grep "find"        # Search command history

# Advanced completion
ls <TAB>                     # File completion
kill <TAB>                   # Process ID completion
git <TAB>                    # Git command completion
```

### Useful Aliases and Functions

Add these to your `~/.zshrc` file:

```bash
# Productivity aliases
alias ll='ls -lah'
alias la='ls -la'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph'

# Development aliases
alias py='python3'
alias serve='python3 -m http.server'
alias jsonpp='python3 -m json.tool'

# System aliases
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ps='ps aux'

# Custom functions
function mkcd() {
    mkdir -p "$1" && cd "$1"
}

function extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
```


