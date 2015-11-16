#!/bin/sh
# Description:	Display a list of all mounted volumes, one line per volume.

diskutil list -plist 			|\
fgrep -A1 '<key>MountPoint</key>' 	|\
fgrep -v '<string>/</string>' 		|\
egrep "</string>$" 			|\
sed 's#</string>##g ; s#.*<string>##g'

exit 0
