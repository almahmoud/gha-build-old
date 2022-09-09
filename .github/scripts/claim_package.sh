#!/bin/bash
set -x
git pull origin main || git reset --hard origin/main

mkdir -p lists
touch tobuild.txt
if [ ! -s tobuild.txt ]; then
      grep -Pzo "(?s)\s*\"\N*\":\s*\[\s*\]" packages.json | awk -F'"' '{print $2}' | grep -v '^$' | xargs -i bash -c 'echo "readytobuild" > lists/{}'

      grep -lr "readytobuild" lists/ | sed 's#lists/##g' > tobuild.txt

      git config --local user.email "action@github.com"
      git config --local user.name "GitHub Action"
      git add tobuild.txt
      git commit -m "Adding To Build list"
      git push

fi

PKGTOBUILD=$(head -n 1 tobuild.txt)
sed 's/readytobuild/claimed/g' "lists/$PKGTOBUILD" && grep -lr "readytobuild" lists/ | sed 's#lists/##g' > tobuild.txt
git add lists
git add tobuild.txt
git commit -m "Claim $PKGTOBUILD"
echo "$PKGTOBUILD" > "tmp$1"
