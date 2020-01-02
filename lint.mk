include github.com/InDebted/make/debug
include github.com/InDebted/make/docker
go_files := $(shell find . -iname '*.go' -type f -not -path "./.go/*" -not -path "./node_modules/*")

.PHONY: lint-dependencies
lint-dependencies:
	$(call _info,Linting dependencies…)
	$(call docker,go mod verify)

.PHONY: lint-format
lint-format:
	$(call _info,Linting format…)
	$(call docker,gofmt -l $(go_files) | tee /dev/fd/2 | xargs test -z)

.PHONY: lint-imports
lint-imports:
	$(call _info,Linting imports…)
	$(call docker,goimports -l $(go_files) | tee /dev/fd/2 | xargs test -z)

# Buildddeee
lint-source:
	$(call _info,Linting source…)
	$(call docker,for file in $(go_files); do golint -set_exit_status "\$$file" 2>&1; done)
.PHONY: lint-source

.PHONY: lint
lint: lint-dependencies lint-format lint-imports lint-source
