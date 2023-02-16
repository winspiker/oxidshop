#!/bin/bash
ZIP=/usr/bin/zip
MODUL_NAME="article_moretabs"
FILENAME="article_moretabs.zip"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" #directory of the current script

cd $DIR
rm -rf package $FILENAME
mkdir package
cd package

mv ../productive/install.sql .
mv ../productive/INSTALL.md .

echo "Copying encrypted files..."
mkdir -p copy_this/modules/$MODUL_NAME
cp -r ../productive/ copy_this/modules/$MODUL_NAME/

echo "Compressing to $FILENAME..."
$ZIP -r -9 -q ../$FILENAME *
cd ..
rm -r package
