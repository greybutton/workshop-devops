USER = "$(shell id -u):$(shell id -g)"

app:
	docker-compose up

app-build:
	docker-compose build

app-bash:
	docker-compose run app bash

app-setup: development-setup-env app-build app-db-prepare
	docker-compose run app bundle install

app-db-prepare:
	docker-compose run app bash -c "bin/rails db:create db:migrate"

development-setup-env:
	ansible-playbook ansible/development.yml -i ansible/development -vv

