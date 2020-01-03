include github.com/InDebted/make/debug
handlers_dir ?= handler
dist_dir ?= bin

.SECONDEXPANSION:
$(dist_dir)/%: $(handlers_dir)/% $$(shell find $(handlers_dir)/% -type f -name '*.go' -not -name '*_test.go')
	$(call _info,Building $*…)
	@go build -ldflags="-s -w" -o $@ ./$<

all_handlers = $(patsubst $(handlers_dir)/%,$(dist_dir)/%, $(wildcard $(handlers_dir)/*))
trash += $(dist_dir)

# Builds all handlers
build: $(all_handlers)
.PHONY: build

.DEFAULT_GOAL := build
