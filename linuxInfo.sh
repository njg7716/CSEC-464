#!/bin/bash
echo -e "\n-----TIME-----"
echo -e "  Current Time, Date And Time Zone:" `date`
echo -e "  The Last Time The System Was Reboot Was" `uptime -sp` "\n"

echo -e "--OS VERSION--"
echo -e "  OS Version:" `cat /etc/os-release | grep -o "PRETTY_NAME.*" | awk '{split($0,a,"\""); print a[2]}'`
echo -e "  Processor name:" `cat /proc/cpuinfo | grep -o "model name.*" | head -1 | awk '{split($0,a,":"); print a[2]}'`
echo -e "  Kernal version:" `uname -r` "\n"


echo -e "-SYSTEM SPECS-"
echo -e "  CPU Architecture Information:" `uname -p`	#TODO
echo -e "  Amount Of Memory In Use:" `free -h | grep -o "Mem:.*" | awk '{split($0,a," "); print a[3]}'`
echo -e "  Amount Of Free Memory:" `free -h | grep -o "Mem:.*" | awk '{split($0,a," "); print a[4]}'`
diskName=`df -h / | grep -o "/dev/.*" | cut -d/ -f3 | cut -d' ' -f1`
echo $diskName
echo -e "  Partition Name:"	"Mounts at:"		#TODO
echo -e "  Hostname:" `hostname`
echo -e "  Domain Name:" `domainname` "\n"

echo -e "---NETWORK---"
echo -e "  MAC Addresses For All Interfaces:"
echo -e "  IP Addresses For All Interfaces:"
echo -e "  Interfaces In Promiscuous Mode:"
echo -e "  Established Network Connections:"

echo ""
