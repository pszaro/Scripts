#!/bin/sh
#
# Description: Using speedtest-cli, checks internet bandwidth
#
# Utilities Needed:
# -speedtest-cli
#

LOG="/Users/${USER}/Desktop/Dropbox/Notes/speedtest.txt"
echo >> ${LOG}
echo "Executed on `hostname`" >> ${LOG}
date >> ${LOG}
/usr/local/bin/speedtest-cli | egrep "Download:|Upload:" >> ${LOG}

tail -5 /Users/${USER}/Desktop/Dropbox/Notes/speedtest.txt
