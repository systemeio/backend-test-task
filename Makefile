USER_ID=$(shell id -u)

DC = @USER_ID=$(USER_ID) docker compose
DC_RUN = ${DC} run --rm sio_test
DC_EXEC = ${DC} exec sio_test

PHONY: help
.DEFAULT_GOAL := help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

init: down build install up success-message console ## Initialize environment

build: ## Build services.
	${DC} build $(c)

up: ## Create and start services.
	${DC} up -d $(c)

stop: ## Stop services.
	${DC} stop $(c)

start: ## Start services.
	${DC} start $(c)

down: ## Stop and remove containers and volumes.
	${DC} down -v $(c)

restart: stop start ## Restart services.

console: ## Login in console.
	${DC_EXEC} /bin/bash

install: ## Install dependencies without running the whole application.
	${DC_RUN} composer install

success-message:
	@echo "You can now access the application at http://localhost:8337"
	@echo "Good luck! 🚀"