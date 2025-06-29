#!/bin/bash

# Server Performance Stats Script

echo "========================================="
echo "       Server Performance Statistics      "
echo "========================================="

# OS Version
echo ""
echo "OS Version:"
cat /etc/os-release | grep -E 'PRETTY_NAME|VERSION='

# Uptime
echo ""
echo "Uptime:"
uptime -p

# Load Average
echo ""
echo "Load Average:"
uptime | awk -F'load average: ' '{ print $2 }'

# Logged-in Users
echo ""
echo "Logged-in Users:"
who | wc -l

# CPU Usage
echo ""
echo "CPU Usage:"
top -bn1 | grep "%Cpu(s)" | \
awk '{usage = 100 - $8; printf "Total CPU Usage: %.2f%%\n", usage}'

# Memory Usage
echo ""
echo "Memory Usage:"
free -m | awk 'NR==2{
    total=$2; used=$3; free=$4;
    printf "Total: %s MB\nUsed: %s MB\nFree: %s MB\nUsed Percentage: %.2f%%\n", 
           total, used, free, used/total * 100
}'

# Disk Usage
echo ""
echo "Disk Usage (Root /):"
df -h / | awk 'NR==2{
    printf "Total: %s\nUsed: %s\nAvailable: %s\nUsed Percentage: %s\n", 
           $2, $3, $4, $5
}'

# Top 5 Processes by CPU Usage
echo ""
echo "Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

# Top 5 Processes by Memory Usage
echo ""
echo "Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6

# Failed Login Attempts (optional)
echo ""
echo "Failed Login Attempts:"
lastb -n 5 2>/dev/null || echo "No 'lastb' command or no failed logins logged."

echo ""
echo "========================================="
echo "         End of Server Report"
echo "========================================="
