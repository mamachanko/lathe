.PHONY: all lathe provision package box drop

all: lathe release

lathe: box provision release package 
		vagrant up
		bin/check
		figlet -f script lathe done

box:
		figlet -f script creating box
		ssh-add
		make drop
		vagrant box update
		vagrant up
		vagrant snapshot save vanilla

drop:
		vagrant halt
		# vagrant snapshot delete $(vagrant snapshot list)
		vagrant destroy --force

provision:
		figlet -f script provisioning box
		ansible-galaxy install -r requirements.yaml
		ansible-playbook playbook.yaml --syntax-check
		rm -f playbook.retry
		ansible-playbook playbook.yaml
		vagrant snapshot save provisioned

package:
		./package.sh

release:
		virtualenv venv
		. venv/bin/activate && pip install -r requirements.txt
		. venv/bin/activate && bumpversion --commit --tag major
		rm -rf venv
		git push origin master
