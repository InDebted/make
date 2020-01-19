# Lints the source files looking for anti-patterns
lint: lint.dependencies lint.format lint.imports lint.source
.PHONY: lint

lint.dependencies:
	@$(call _info,Linting dependencies…)
	@go mod verify
	$(call _info,Linting dependencies finished!)
.PHONY: lint.dependencies

lint.format:
	@$(call _info,Linting format…)
	@gofmt -l $(shell $(call git-ls,'*.go')) | tee /dev/fd/2 | xargs test -z
	$(call _info,Linting format finished!)
.PHONY: lint.format

lint.imports:
	@$(call _info,Linting imports…)
	@goimports -l $(shell $(call git-ls,'*.go')) | tee /dev/fd/2 | xargs test -z
	$(call _info,Linting imports finished!)
.PHONY: lint.imports

lint.source:
	@$(call _info,Linting source…)
	@$(call git-ls,'*.go') | xargs -n1 golint -set_exit_status 2>&1
	$(call _info,Linting source finished!)
.PHONY: lint.source
