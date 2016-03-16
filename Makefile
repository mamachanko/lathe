.PHONY: lathe

lathe:
		ssh-add
		vagrant halt
		vagrant destroy --force
		vagrant box update
		vagrant up
		ansible-galaxy list | awk -F'[, ]' '{print $2}' | xargs ansible-galaxy remove
		ansible-galaxy install -r requirements.yaml
		ansible-playbook playbook.yaml
