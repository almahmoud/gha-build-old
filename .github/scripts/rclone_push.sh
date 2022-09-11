#!/bin/bash
set -xe
git pull origin main || git reset --hard origin/main

PKGTOMARK=$1
TAR=$2
echo "$TAR" > "lists/$PKGTOMARK"
sed -i "s/    \"$PKGTOMARK\": \[\],\?//g" packages.json
sed -i "s/        \"$PKGTOMARK\",\?//g" packages.json
sed -i -z 's/,\n\n\+}/}/g' packages.json
sed -i -z 's/,\n\n\+ *]/]/g' packages.json
python -c 'import json; f = open("packages.json", "r"); pkgs = json.load(f); f.close(); f = open("packages.json", "w"); f.write(json.dumps(pkgs, indent=4)); f.close()'
git add lists
git add packages.json
git commit -m "Mark pushed $PKGTOMARK"
git push
