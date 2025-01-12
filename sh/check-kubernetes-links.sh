#!/bin/bash

for link in $(fgrep -r "kubernetes.io" ../website/ | sed -n 's/.*href="\([^"]*\).*/\1/p' | grep kubernetes-api);
do
	echo "Checking:$link"
	res="$(wget -qNS $link 2>&1 -O /dev/null | grep "HTTP/" | awk '{print $2}')"
	if [ $res = 404 ]; then
		echo "Link broken"
	fi
	if [ $res = 200 ]; then
		echo "Link ok"
	fi
done
