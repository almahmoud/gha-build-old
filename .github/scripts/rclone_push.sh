#!/bin/bash
set -x
git pull origin main || git reset --hard origin/main

PKGTOMARK=$1
TAR=$2
rclone copyto /tmp/$2 js2:/gha-build//tmp/$2 -vvvvvv && sed 's/built/pushed/g' "lists/$PKGTOMARK"
git add lists
git commit -m "Mark pushed $PKGTOMARK"
