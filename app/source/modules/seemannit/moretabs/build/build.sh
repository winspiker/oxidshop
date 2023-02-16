#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" #directory of the current script

cd build

rm -rf tmp
rm -rf productive

mkdir tmp
cd tmp

echo "Retrieving code from GIT repo..."
git clone --quiet ../.. .

rm -rf .git .gitignore README.md build/

cd $DIR
mv tmp productive

./package.sh
