#!/bin/bash
set -x
git pull origin main || git reset --hard origin/main
LIBRARY=$1
PKG=$2
mkdir -p built/
mkdir -p tars/
mkdir -p logs/
mkdir -p /tmp/built/
mkdir -p /tmp/tars/
mkdir -p /tmp/logs/
Rscript -e "p <- .libPaths(); p <- c('$LIBRARY', p); .libPaths(p); if(BiocManager::install('$PKG', INSTALL_opts = '--build', update = TRUE, quiet = TRUE, force = TRUE, keep_outputs = TRUE) %in% rownames(installed.packages())) q(status = 0) else q(status = 1)" && cp *.tar.gz /tmp/tars/ && cp *.out /tmp/logs/ && cp -r "built/$PKG" /tmp/built/
