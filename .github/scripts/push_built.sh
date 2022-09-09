#!/bin/bash
set -x
git pull origin main || git reset --hard origin/main

PKG=$1
sed 's/claimed/built/g' "lists/$PKG"
git add lists
cp /tmp/tars/*.tar.gz tars/
cp /tmp/logs/*.out logs/
cp -r "/tmp/built/$PKG" "built/$PKG"
git add tars
git add logs
git add built
git commit -m "Built $PKG"
