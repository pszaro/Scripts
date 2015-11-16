#!/bin/bash
# Description: This script generates a dynamic README file.
#

> README.md

header='================='
subheader='-----------------'

#####################################################
#####################################################

#echo "                   " >> README.md
#echo "(Insert title here)" >> README.md
#echo "$header" >> README.md

echo "                   " >> README.md
echo "Introduction" >> README.md
echo "$subheader" >> README.md
description=`more .git/description`
echo $description >> README.md

echo "                   " >> README.md
echo "GIT Repo Location" >> README.md
echo "$subheader" >> README.md
giturl=`git config --list | grep remote | cut -c22-60`
echo $giturl >> README.md

echo "                   " >> README.md
echo "List of Scripts" >> README.md
echo "$subheader" >> README.md

for i in *sh
do
  egrep "^# Description:" "$i" | sed "s/^# Description:/\\
  - [$i]:\\
  /g" >> README.md
done

#echo '\n\n' >> README.md
echo >> README.md

#####################################################
#####################################################

cat README.md

