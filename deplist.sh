#!/bin/bash

deplist() {
	local pkg="$1"
	sed -n '/^pkgbase/,/^pkgname/p' "$pkg/.SRCINFO" | \
	awk -F ' = ' '/([^a-z]|make)depends =/{print $2}'
}

providelist() {
	local pkg="$1"
	sed -n '/^pkgbase/,/^pkgname/p' "$pkg/.SRCINFO" | \
	awk -F ' = ' '/(provides|pkgname) =/{print $2}'
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
