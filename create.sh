#!/bin/sh
REPO_DIR="."
REPO_NAME="classic"
for i in i586 i686 x86_64 noarch; do
  mkdir -p "$REPO_DIR/$i/base" "$REPO_DIR/$i/RPMS.$REPO_NAME"
done
