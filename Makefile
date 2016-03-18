.PHONY: lathe provision check

lathe:
		ssh-add
		vagrant halt
		vagrant destroy --force
		vagrant box update
		vagrant up
		rm -rf .ansible
		ansible-galaxy install -r requirements.yaml
		ansible-playbook playbook.yaml --syntax-check
		ansible-playbook playbook.yaml
		./check.sh

provision: check
		ansible-playbook playbook.yaml

check:
		ansible-galaxy install -r requirements.yaml
		ansible-playbook playbook.yaml --syntax-check
		./check.sh
