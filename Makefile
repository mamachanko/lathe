LATHE_VERSION=$(shell cat VERSION)
BUILD_DIR=./build
BOX_NAME=lathe-${LATHE_VERSION}.box
BOX_PATH=${BUILD_DIR}/${BOX_NAME}

.PHONY: lathe provision package box test bump

lathe: box provision test package 
		vagrant up
		bin/check
		figlet -f script lathe done

box:
		figlet -f script creating box
		ssh-add
		vagrant halt
		vagrant destroy --force
		vagrant box update
		vagrant up

provision:
		figlet -f script provisioning box
		rm -rf .ansible
		ansible-galaxy install -r requirements.yaml
		ansible-playbook playbook.yaml --syntax-check
		rm -f playbook.retry
		ansible-playbook playbook.yaml

package:
		figlet -f script packaging box
		figlet -f script ${BOX_NAME}
		vagrant package --output ${BOX_PATH}

test:
		bin/test ${BOX_PATH}

bump:
		bumpversion --dry-run part major

release:
		bin/release ${BOX_PATH}
