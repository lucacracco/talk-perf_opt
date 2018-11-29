include .env

.PHONY: up down stop prune ps shell logs

default: help

up: ## Starting up containers for project
	@echo "Starting up containers for $(PROJECT_NAME)..."
	docker-compose pull
	docker-compose up -d --remove-orphans

down: stop ## Stop containers for project

stop: ## Stop containers for project
	@echo "Stopping containers for $(PROJECT_NAME)..."
	@docker-compose stop

prune: ## Stop and prune containers for project
	@echo "Removing containers for $(PROJECT_NAME)..."
	@docker-compose down -v

ps: ## List container for project
	@docker ps --filter name='$(PROJECT_NAME)*'

shell: ## Open the shell the container
	docker exec -ti -e COLUMNS=$(shell tput cols) -e LINES=$(shell tput lines) $(shell docker ps --filter name='$(PROJECT_NAME)_revealjs' --format "{{ .ID }}") bash

logs: ## List container for project
	@docker-compose logs -f $(filter-out $@,$(MAKECMDGOALS))

help: ## List of commands
	@eval $$(sed -r -n 's/^([a-zA-Z0-9_-]+):.*?## (.*)$$/printf "\\033[36m%-30s\\033[0m %s\\n" "\1" "\2" ;/; ta; b; :a p' $(MAKEFILE_LIST))

# https://stackoverflow.com/a/6273809/1826109
%:
@: