#!/bin/bash
#
# C: Description: Script created to run often on Mac to scan for any recent trojans being discovered
#
# 05/08/2017 - Handbrake: https://forum.handbrake.fr/viewtopic.php?f=33&t=36364
# 05/20/2018 - mshelper: https://www.imore.com/how-find-and-remove-mshelper-malware-your-mac
#

ps -ef | grep "Activity_agent" | grep -v "grep"
if [ "$?" -eq "0" ]
then
  echo "`hostname` infected by a trojan related to HandBrake. Please see https://forum.handbrake.fr/viewtopic.php?f=33&t=36364 for more info"
  growlnotify --appIcon Xcode System -m '"`hostname` infected by a trojan related to HandBrake"' -i Terminal -s
fi

# https://www.imore.com/how-find-and-remove-mshelper-malware-your-mac
ps -ef | grep "mshelper" | grep -v "grep"
if [ "$?" -eq "0" ]
then
  echo "`hostname` infected by a trojan related to mshelper."
  growlnotify --appIcon Xcode System -m '"`hostname` infected by a trojan related to mshelper"' -i Terminal -s
fi
