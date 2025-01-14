#!/bin/bash

FIND_VERSION="v1.23"
REPLACE_VERSION="v1.31"

for link in $(fgrep -r "kubernetes.io" ../website/ | sed -n 's/.*href="\([^"]*\).*/\1/p' | grep $FIND_VERSION);
do
	filename=$(fgrep -rH "$link" ../website/ | cut -d: -f1 | head -n 1)
	echo "Replacing:$link in file:$filename"
	if [ -n "$filename" ]; then
		sed -i "s/\/$FIND_VERSION\//\/$REPLACE_VERSION\//g" $filename
	fi
done
