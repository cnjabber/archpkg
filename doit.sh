#!/bin/bash
set -e

WORK="$PWD"
_repo_add=()
for i in `cat LIST`; do
	cd "$i"
	makepkg -cs -i --needed --noconfirm
	_pkgtars=(`makepkg --packagelist`)
	for pkgtar in "${_pkgtars[@]}"
	do
		if [[ "${pkgtar}" =~ -i686$ ]]
		then
			continue
		fi
		cp "${pkgtar}.pkg.tar.xz" /srv/http/repo/matrixim/x86_64/
		_repo_add=("${_repo_add[@]}" "/srv/http/repo/matrixim/x86_64/${pkgtar}.pkg.tar.xz")
	done
	cd "$WORK"
done

rm -f /srv/http/repo/matrixim/x86_64/matrixim.db.tar.gz
repo-add -n -R \
	/srv/http/repo/matrixim/x86_64/matrixim.db.tar.gz \
	"${_repo_add[@]}"
