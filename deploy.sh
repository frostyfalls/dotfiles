#!/bin/sh

file="MANIFEST"

while IFS='|' read -r src dst; do
	: "${dst:=$src}"
	case "$dst" in
		/*) ;;
		*) dst="$HOME/$dst" ;;
	esac
	if [ -r "$dst" ]; then
		echo "[warn] $dst exists" >&2
		continue
	fi
	mkdir -p "$(dirname "$dst")"
	echo "$src -> $dst"
	ln -srT "$src" "$dst"
done <"$file"
