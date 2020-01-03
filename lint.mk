go_files := $(shell find $$(ls -d */ | grep -v 'node_modules/') -iname '*.go' -type f)

# Lints the source files looking for anti-patterns
lint: lint-dependencies lint-format lint-imports lint-source
.PHONY: lint

lint-dependencies:
	$(call _info,Linting dependencies…)
	@go mod verify
.PHONY: lint-dependencies

lint-format:
	$(call _info,Linting format…)
	@gofmt -l $(go_files) | tee /dev/fd/2 | xargs test -z
.PHONY: lint-format

lint-imports:
	$(call _info,Linting imports…)
	@goimports -l $(go_files) | tee /dev/fd/2 | xargs test -z
.PHONY: lint-imports

lint-source:
	$(call _info,Linting source…)
	@for file in $(go_files); do golint -set_exit_status "$$file" 2>&1; done
.PHONY: lint-source
