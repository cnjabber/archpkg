#!/bin/bash
set -e

WORK="$PWD"
for i in `cat LIST`; do
	cd "$i"
	makepkg -cs -i --needed --noconfirm
	cp *.pkg.tar.xz /srv/http/repo/matrixim/x86_64/
	repo-add -n -R \
		/srv/http/repo/matrixim/x86_64/matrixim.db.tar.gz \
	       	/srv/http/repo/matrixim/x86_64/*.pkg.tar.xz
	cd "$WORK"
done

