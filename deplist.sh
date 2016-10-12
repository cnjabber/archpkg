#!/bin/bash

deplist() {
	local pkg="$1"
	awk -F ' = ' '/([^a-z]|make)depends =/{print $2}' \
		"$pkg/.SRCINFO"
}

providelist() {
	local pkg="$1"
	awk -F ' = ' '/(provides|pkgname) =/{print $2}' \
		"$pkg/.SRCINFO"
}

for pkg in */; do
	_pkg=${pkg%/}
	_dep=($(deplist $_pkg))
	_provide=($(providelist $_pkg))
	for i in "${_dep[@]}"; do
		echo "${i%[<=>]} $_pkg"
	done
	for i in "${_provide[@]}"; do
		echo "$_pkg ${i%[<=>]}"
	done
done
