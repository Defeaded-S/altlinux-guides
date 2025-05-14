#!/bin/sh
REPO_NAME="classic"

for arch in i586 i686 x86_64 noarch; do
  mkdir -p $arch/RPMS.$REPO_NAME
  genbasedir --create --progress --topdir=. $arch $REPO_NAME
done
