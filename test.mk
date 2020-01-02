include github.com/InDebted/make/debug
go_modules = $(shell go list ./... | grep -v /node_modules/)

.PHONY: test
test:
	$(call _info,Testing…)
	@go test -count=1 $(ARGS) $(go_modules)
