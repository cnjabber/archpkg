#!/bin/sh

LIST=($(./deplist.sh|tsort))
for i in "${LIST[@]}"; do
	if [ -d "$i" ]; then
		echo "$i"
	fi
done
