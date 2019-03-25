include make-app.mk
include make-ansible.mk

U := root
VPF := tmp/ansible-vault-password

project-setup: project-files-touch project-env-generate app-setup

project-files-touch:
	mkdir -p tmp
	touch tmp/ansible-vault-password

project-env-generate:
	docker run -it -v $(CURDIR):/app -w /app williamyeh/ansible:ubuntu18.04 ansible-playbook ansible/development.yml -i ansible/development -vv

terraform-vars-generate:
	docker run -it -v $(CURDIR):/app -w /app williamyeh/ansible:ubuntu18.04 ansible-playbook ansible/terraform.yml -i ansible/production -vv --vault-password-file=tmp/ansible-vault-password

production-deploy:
	ansible-playbook ansible/deploy.yml -i ansible/production -u $U --vault-password-file=$(VPF)
