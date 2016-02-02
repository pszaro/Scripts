#/bin/sh
# 
# Description: Use this to display service status info on my desktop using GeekTool
#
# External IP Address
echo "Extenal IP: `dig +short myip.opendns.com @resolver1.opendns.com`"
# Internal IP Address
echo "Internal IP: `ipconfig getifaddr en0`"
# Current SSID
echo "Current SSID: `/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}'`"
#Current Resolution
echo "Current `system_profiler SPDisplaysDataType | grep Resolution | awk '{print $1,$2,$3,$4,$5}'`"
# CPU
echo "CPU: `sysctl -n machdep.cpu.brand_string`"
# Bluetooth
defaults read /Library/Preferences/com.apple.Bluetooth ControllerPowerState > /dev/null
if [ $? = 1 ]
then
  echo "Bluetooth Status: Enabled"
else
  echo "Bluetooth Status: Disabled"
fi
# Infrared Receiver
defaults read /Library/Preferences/com.apple.driver.AppleIRController DeviceEnabled > /dev/null
if [ $? = 1 ]
then
  echo "Infrared Receiver Status: Enabled"
else
  echo "Infrared Receiver Status: Disabled"
fi
# Firewall 
/usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate
# FileVault Service
fdesetup status



