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
		ansible-playbook playbook.yaml

package: lathe
		vagrant package --output 'mamachanko/lathe'
