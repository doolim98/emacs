#!/bin/bash -eux

brew install cask  --ignore-dependencies

TMP_D=$(mktemp -d)
cd $TMP_D
git clone https://github.com/vedang/pdf-tools
cd pdf-tools
make -s # If you don't have make installed, run ./server/autobuild and it will install make
