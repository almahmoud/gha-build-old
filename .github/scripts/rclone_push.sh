#!/bin/bash
set -x
git pull origin main || git reset --hard origin/main

PKGTOMARK=$1
sed -i 's/built/pushed/g' "lists/$PKGTOMARK"
git add lists
git commit -m "Mark pushed $PKGTOMARK"
