#!/bin/bash
echo -e "\n-----TIME-----"
echo -e "  Current Time, Date And Time Zone:" `date`
echo -e "  The Last Time The System Was Reboot Was" `uptime -sp` "\n"

echo -e "--OS VERSION--"
echo -e "  OS Version:" `cat /etc/os-release | grep -o "PRETTY_NAME.*" | awk '{split($0,a,"\""); print a[2]}'`
echo -e "  Processor name:" `cat /proc/cpuinfo | grep -o "model name.*" | head -1 | awk '{split($0,a,":"); print a[2]}'`
echo -e "  Kernal version:" `uname -r` "\n"


echo -e "-SYSTEM SPECS-"
echo -e "  CPU Architecture Information:" `uname -p`
echo -e "  Amount Of Memory In Use:" `free -h | grep -o "Mem:.*" | awk '{split($0,a," "); print a[3]}'`
echo -e "  Amount Of Free Memory:" `free -h | grep -o "Mem:.*" | awk '{split($0,a," "); print a[4]}'`
diskName=`lsblk | grep -o ".*disk" | cut -d' ' -f1`
echo -e "  Disk Name:" $diskName `df -h | grep -o "$diskName.*" | head -1 | cut -d' ' -f12` "Full" 
echo -e "\n  Partitions"
lsblk -o NAME,MOUNTPOINT
echo -e "\n  Hostname:" `hostname`
echo -e "  Domain Name:" `domainname` "\n"

echo -e "---NETWORK---"
echo -e "  MAC Addresses For All Interfaces:"
ip maddress
echo -e "  IP Addresses For All Interfaces:" `ip a | grep -o "inet .*" | cut -d' ' -f2`
echo -e "  Interfaces In Promiscuous Mode:"  `ip a | grep -E "PROMISC" | cut -d' ' -f2 | cut -d':' -f1`
echo -e "  Established Network Connections:"
netstat -antp | grep -E "ESTABLISHED" 2> /dev/null

echo ""
echo -e "----Users----"
echo "Users Currently Logged In:"
users
echo "All Users That Have Logged In:"
awk -F: '$3 >= 500 {print $1}' /etc/passwd
echo "Users with UID 0:"
awk -F: '$3 == 0 {print $1}' /etc/passwd
echo "All SUID Files:"
find / -perm /4000 2> /dev/null
echo "---Processes and Open Files---"
echo "All Processes:"
ps -eaf | top
echo "All Files Opened By nc:"
lsof -c nc | awk -F' ' ' $11!=""{print $11}'
echo "All Opened and Unlinked Files:"
lsof -a +L1 | awk -F' ' ' $11!=""{print $10}'

echo "----MISC----"
echo "Files In /home That Have Been Modified In The Last Day:"
find /home -mtime -1
echo "Scheduled Tasks For Root"
sudo crontab -l
echo "Auth Log:"
tail /var/log/auth.log
echo -e "\nSys Log:"
tail /var/log/syslog
echo "Command History:"
history

echo ""
