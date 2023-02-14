#!/bin/bash

mkdir -p files/root
pushd files/root

tar -xzf $GITHUB_WORKSPACE/scripts/dotfile.tar.gz -C .

popd
