LATHE_VERSION=$(shell cat VERSION)
BUILD_DIR=./build
BOX_NAME=lathe-${LATHE_VERSION}.box
BOX_PATH=${BUILD_DIR}/${BOX_NAME}

.PHONY: all lathe provision package box drop

all: lathe release

lathe: box provision bump package 
		vagrant up
		bin/check
		figlet -f script lathe done

box:
		figlet -f script creating box
		ssh-add
		make drop
		vagrant box update
		vagrant up

drop:
		vagrant halt
		vagrant destroy --force

provision:
		figlet -f script provisioning box
		ansible-galaxy install -r requirements.yaml
		ansible-playbook playbook.yaml --syntax-check
		rm -f playbook.retry
		ansible-playbook playbook.yaml

package:
		figlet -f script packaging box
		figlet -f script ${BOX_NAME}
		vagrant package --output ${BOX_PATH}

release:
		virtualenv venv
		. venv/bin/activate && pip install -r requirements.txt
		. venv/bin/activate && bumpversion --commit --tag major
		rm -rf venv
		git push origin master
