handlers_dir ?= handler
dist_dir ?= bin
trash += $(dist_dir)
all_handlers = $(patsubst $(handlers_dir)/%,$(dist_dir)/%,$(wildcard $(handlers_dir)/*))

.SECONDEXPANSION:
source_files += $$(shell $$(call git-ls,'$$(handlers_dir)/%/*.go') | grep -v '_test.go')
source_files += $(shell $(call git-ls,'*.go' ':(exclude,glob)$(handlers_dir)/**') | grep -v '_test.go')
$(dist_dir)/%: $(handlers_dir)/% $(source_files) | go-modules
	@$(call _info,Building $*…)
	@env GOOS=linux go build -ldflags="-s -w" -o $@ ./$<

# Builds all handlers
build: $(all_handlers)
.PHONY: build
