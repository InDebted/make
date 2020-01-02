include github.com/InDebted/make/debug
include github.com/InDebted/make/docker
handlers_dir ?= handler
dist_dir ?= bin

.SECONDEXPANSION:
$(dist_dir)/%: $(handlers_dir)/% $$(shell find $(handlers_dir)/% -type f -name '*.go' ! -name '*_test.go')
	$(call _info,Building $*…)
	$(call docker,go build -ldflags=\"-s -w\" -o $@ ./$<)

all_handlers = $(patsubst $(handlers_dir)/%,$(dist_dir)/%, $(wildcard $(handlers_dir)/*))
trash += $(dist_dir)

.PHONY: build
build: $(all_handlers)

.DEFAULT_GOAL := build
