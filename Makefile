TF     := terraform

.PHONY:
clean: ## Remove all generated files
	@rm -rf .terraform.lock.hcl plan.out terraform.tfstate*

.PHONY:
clean-all: clean ## Remove all generated files and terraform cache
	@rm -rf .terraform

.PHONY:
lint: ## Format terraform files
	@$(TF) fmt \
		-diff=true \
		-check

.PHONY:
fmt: ## Format terraform files
	@$(TF) fmt

.PHONY:
validate: init ## Validate terraform files
	@$(TF) validate

.PHONY:
init: .terraform.lock.hcl ## Initialize terraform

.terraform.lock.hcl: *.tf
	@$(TF) init

.PHONY:
help:
	@echo "Usage: make [target]"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | sed -E 's/^(.+): ([^#]+)?##\s*(.+)$$/\1 \3/' | column --table --table-columns-limit 2