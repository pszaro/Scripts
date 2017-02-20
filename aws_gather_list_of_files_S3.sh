#!/bin/ksh
#
# Description: Connects to Amazon S3 and gathers list of all files in all buckets
#

DATE=$(date +"%B"-%d"-"%Y)
ARCHIVEDIR="$HOME/Desktop/Dropbox/Notes"
S3LOG="S3_Complete_List_Of_Files.txt"

echo
echo "Gathering list of files in all S3 Buckets..."
echo

> "$ARCHIVEDIR/$S3LOG"

for p in `aws s3 ls | awk '{print $3}'`
do 
  echo $p >> "$ARCHIVEDIR/$S3LOG"
  aws s3 ls s3://$p --recursive --human-readable --summarize>> "$ARCHIVEDIR/$S3LOG"
  echo >> "$ARCHIVEDIR/$S3LOG"
done

exit
