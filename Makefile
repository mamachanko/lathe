.PHONY: lathe provision package box

lathe: box provision package 
		vagrant up
		./check.sh
		figlet -f script lathe done

provision:
		figlet -f script provisioning box
		rm -rf .ansible
		ansible-galaxy install -r requirements.yaml
		ansible-playbook playbook.yaml --syntax-check
		rm playbook.retry
		ansible-playbook playbook.yaml

package:
		figlet -f script packaging box
		rm -rf _build
		mkdir _build
		vagrant package --output ./_build/lathe.box

box:
		figlet -f script creating box
		ssh-add
		vagrant halt
		vagrant destroy --force
		vagrant box update
		vagrant up
