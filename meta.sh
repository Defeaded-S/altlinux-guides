#!/bin/sh
REPO_NAME="$2"

for arch in x86_64-i586 x86_64 noarch; do
  genbasedir --bloat --progress --topdir=. $arch $REPO_NAME
done
