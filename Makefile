.PHONY: lathe provision package

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

provision:
		ansible-galaxy install -r requirements.yaml
		ansible-playbook playbook.yaml --syntax-check
		ansible-playbook playbook.yaml

package: lathe
		rm -rf _build
		mkdir _build
		vagrant package --output ./_build/lathe.box
