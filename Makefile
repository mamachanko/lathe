.PHONY: lathe

lathe:
		ssh-add
		vagrant halt
		vagrant destroy --force
		vagrant box update
		vagrant up
		ansible-playbook playbook.yaml
