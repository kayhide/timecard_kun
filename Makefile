RAILS_ENV ?= development
COMPOSE_PROJECT_NAME := timecard_kun
COMPOSE_COMMAND := docker-compose


guard:
	@eval "$(MAKE) envs" && bundle exec guard
.PHONY: guard

infra-up:
	${COMPOSE_COMMAND} up -d
	@bundle exec spring stop
	@eval "$(MAKE) envs" && rails db:setup || rails db:migrate
.PHONY: infra-up

infra-down:
	${COMPOSE_COMMAND} down
	@bundle exec spring stop
.PHONY: infra-down

rails-update:
	@eval "$(shell $(MAKE) envs)" && bin/update
.PHONY: rails-update

envs: DB_PORT = $(shell docker inspect $(COMPOSE_PROJECT_NAME)-db-1 | jq -r '.[].NetworkSettings.Ports."5432/tcp"[-1].HostPort')
envs:
	@echo "export DB_PORT=${DB_PORT}"
.PHONY: envs

rails-console:
	@eval "$(shell $(MAKE) envs)" && rails console
.PHONY: rails-console

db-console:
	@eval "$(shell $(MAKE) envs)" && psql -U postgres -h localhost -p $$DB_PORT -d timecard_kun_${RAILS_ENV}
.PHONY: db-console
