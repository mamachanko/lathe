#! /bin/bash

set -e

LATHE_VERSION=$(cat VERSION)
BUILD_DIR=./build
BOX_NAME=lathe-$LATHE_VERSION.box
BOX_PATH=$BUILD_DIR/$BOX_NAME

figlet -f script packaging box
figlet -f script ${BOX_NAME}

vagrant package --output ${BOX_PATH} --vagrantfile Vagrantfile
vagrant box add --force --name mamachanko/lathe ${BOX_PATH} 
