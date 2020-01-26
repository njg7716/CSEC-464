"Date:"
Get-Date

"Timezone:"
get-timezone | select DisplayName

"Name:"
Get-CimInstance -ClassName win32_operatingsystem | select csname

"Last Reboot:"
Get-CimInstance -ClassName win32_operatingsystem | select lastbootuptime

"Procesor:"
Get-WmiObject Win32_Processor | select Name

"OS Version:"
Get-CimInstance Win32_OperatingSystem | Select-Object  Caption, ServicePackMajorVersion, BuildNumber


"Architecture:"
$arch = (Get-WMIObject -Class Win32_Processor).Architecture
if ($arch -eq '9') {
# Do 64-bit stuff
echo “64-bit Architecture”
}
if ($arch -eq '0') {
# Do 64-bit stuff
echo “x86 Architecture”
}
if ($arch -eq '1') {
# Do 64-bit stuff
echo “MIPS Architecture”
}
if ($arch -eq '2') {
# Do 64-bit stuff
echo “Alpha Architecture”
}
if ($arch -eq '3') {
# Do 64-bit stuff
echo “PowerPC Architecture”
}
if ($arch -eq '6') {
# Do 64-bit stuff
echo “ia64 Architecture”
}
echo ""

"Used memory (Gigabytes:"
$os = Get-Ciminstance Win32_OperatingSystem
($os.TotalVisibleMemorySize - $os.FreePhysicalMemory) /1000000

"Free memory:"
 $os.FreePhysicalMemory/1000000

"Information About Drives:"
gdr -PSProvider 'FileSystem' | select Root, Used, Free

"Unmounted and Mounted Partitions:"
gwmi -class win32_DiskPartition

"Hostname:"
(Get-WmiObject win32_computersystem).DNSHostName

echo ""
"Domain Name: "
(Get-WmiObject win32_computersystem).Domain

"Interface Information:"
ipconfig /all

"Interfaces in Promiscous Mode: "
Get-NetAdapter | Format-List -Property ifAlias,PromiscuousMode

"Established Connections:"
Get-NetTCPConnection -State Established
echo ""

echo $user
"Users Currently Logged in: "
Get-WmiObject -Class Win32_UserAccount
