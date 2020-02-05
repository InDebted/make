ifneq (, $(shell which pre-commit))
.git/hooks/pre-commit: .pre-commit-config.yaml
	@$(call _info,Updating pre-commit hooks…)
	@pre-commit install --install-hooks
	@touch $@

test: | .git/hooks/pre-commit
build: | .git/hooks/pre-commit
deploy: | .git/hooks/pre-commit
endif
