# Makefile for the Mosquitto module.
# Run targets from inside the mosquitto/ directory: `make <target> VAR=value`.

# --- Configuration (override on the command line, e.g. `make create-user USER=oasis`) ---
CONFIG_DIR   ?= config
PASSWD_FILE  ?= $(CONFIG_DIR)/passwd.txt
ACL_FILE     ?= $(CONFIG_DIR)/acl.conf

CONTAINER    ?= mosquitto

# Parameter for user targets.
USER         ?=

.DEFAULT_GOAL := help

# =============================================================================
# Help
# =============================================================================

.PHONY: help
help: ## Show this help.
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-22s\033[0m %s\n", $$1, $$2}'

# =============================================================================
# Static configuration (file-based: password_file + acl_file)
#   These edit the local config files. Changes require `make build` (rebuild)
#   to persist, since the files are baked into the image at build time.
# =============================================================================

.PHONY: verify-install
verify-install: ## Verify the Mosquitto CLI tools are installed.
	mosquitto_passwd

.PHONY: init-files
init-files: ## Create empty passwd and acl files.
	touch $(PASSWD_FILE)
	touch $(ACL_FILE)

.PHONY: create-user
create-user: ## Create/update a user in the passwd file (USER=<name>).
	@test -n "$(USER)" || (echo "ERROR: set USER=<name>"; exit 1)
	mosquitto_passwd $(PASSWD_FILE) $(USER)

.PHONY: delete-user
delete-user: ## Remove a user from the passwd file (USER=<name>).
	@test -n "$(USER)" || (echo "ERROR: set USER=<name>"; exit 1)
	mosquitto_passwd -D $(PASSWD_FILE) $(USER)

.PHONY: edit-acl
edit-acl: ## Open the acl file in an editor to add/edit ACLs.
	$(EDITOR) $(ACL_FILE)

# =============================================================================
# Live config reload / lifecycle
# =============================================================================

.PHONY: reload
reload: ## Reload passwd/acl files in the running broker without restarting (SIGHUP).
	docker kill -s HUP $(CONTAINER)

.PHONY: build
build: ## Rebuild and recreate the mosquitto service (persists file changes).
	docker compose up -d --build $(CONTAINER)
