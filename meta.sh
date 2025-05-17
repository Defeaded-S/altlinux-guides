#!/bin/sh
REPO_DIR="$1"
REPO_NAME="$2"

for arch in x86_64-i586 x86_64 noarch; do
  genbasedir --bloat --progress --topdir=$REPO_DIR $arch $REPO_NAME
done
