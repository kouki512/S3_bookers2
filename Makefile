.PHONY: up lint format install uninstall

build:
	docker compose build

up:
	docker compose up

down:
	docker compose down

stop:
	docker compose stop

routes:
	docker compose run web rails routes

c:
	docker compose run web rails c

migrate:
	docker compose run web rails db:migrate

migrate-status:
	docker compose run web rails db:migrate:status

migrate-down:
	docker compose run web rails db:migrate:down VERSION=${P}

migrate-reset:
	docker compose run web rails db:migrate:reset
seed:
	docker compose run web rails db:seed

db-setup:
	docker compose run web rails db:migrate
	docker compose run web rails db:seed

bundle-install:
	docker compose run web bundle install

