#!/bin/bash

mkdir -p files/root
pushd files/root

tar -xzf $GITHUB_WORKSPACE/scripts/dotfile.tgz -C .

popd
