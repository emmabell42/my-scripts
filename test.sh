#!/bin/bash
while read LINE
do
OUTNAME=$(echo $LINE | cut -d "/" -f 3 | cut -d "." -f 1)
echo $OUTNAME
done < test.txt
