#!/bin/sh
#
# Description: Using speedtest-cli, checks internet bandwidth
#
LOG="/Users/${USER}/Desktop/Dropbox/Notes/speedtest.txt"
echo >> ${LOG}
echo "Executed on `hostname`" >> ${LOG}
date >> ${LOG}
/usr/local/bin/speedtest-cli | egrep "Download:|Upload:" >> ${LOG}
