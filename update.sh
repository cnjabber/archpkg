#!/bin/sh

for i in */
do
	cd "$i"
	git pull
	cd ..
done
