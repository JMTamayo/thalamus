# Makefile for the thalamus project.
# Wraps the docker compose commands used to run the stack.

# Optional: restrict a target to a single service, e.g. `make up SERVICE=mosquitto`.
SERVICE ?=

.DEFAULT_GOAL := help

.PHONY: help
help: ## Show this help.
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2}'

.PHONY: up
up: ## Start the stack in detached mode.
	docker compose up -d $(SERVICE)

.PHONY: build
build: ## Build (or rebuild) images and start the stack.
	docker compose up -d --build $(SERVICE)

.PHONY: down
down: ## Stop and remove the stack.
	docker compose down

.PHONY: restart
restart: ## Restart the stack (or a single SERVICE).
	docker compose restart $(SERVICE)

.PHONY: stop
stop: ## Stop the stack without removing containers.
	docker compose stop $(SERVICE)

.PHONY: ps
ps: ## List the running containers.
	docker compose ps

.PHONY: logs
logs: ## Follow the logs (or a single SERVICE).
	docker compose logs -f $(SERVICE)
