handlers_dir ?= handler
dist_dir ?= bin
trash += $(dist_dir)
all_handlers = $(patsubst $(handlers_dir)/%,$(dist_dir)/%, $(wildcard $(handlers_dir)/*))

.SECONDEXPANSION:
$(dist_dir)/%: $(handlers_dir)/% $$(shell find $(handlers_dir)/% -type f -name '*.go' -not -name '*_test.go') | go-modules
	$(call _info,Building $*…)
	@env GOOS=linux go build -ldflags="-s -w" -o $@ ./$<

# Builds all handlers
build: $(all_handlers)
.PHONY: build
