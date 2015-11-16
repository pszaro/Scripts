#!/bin/sh
#
# Description: Determines last day of the current month
#

TODAY=`/bin/date +%d`
LAST_DAY=`cal | awk '{print $NF}' | tr -s ['\n'] | awk '{print $NF}' | sed -n '$p'`

# See if tomorrow's day is less than today's
if [ $LAST_DAY -eq $TODAY ];
then
      exit 0
fi

exit 1
