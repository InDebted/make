include github.com/InDebted/make/debug
SHELL := /usr/bin/env bash -eu -o pipefail -c
CPUS ?= $(shell (nproc --all || sysctl -n hw.ncpu) 2>/dev/null || echo 1)
CPUS := $(CPUS)
MAKEFLAGS += --jobs=$(CPUS)
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --output-sync=target
.POSIX:
.DELETE_ON_ERROR:
.SUFFIXES:

.PHONY: clean
# Cleans up generated files
clean:
	$(call _info,Cleaning…)
	@rm -rf $(trash)

.PHONY: clobber
# Cleans up the repository as if it was just cloned
clobber:
	$(call _info,Clobbering…)
	@git clean -xfdn | cut -c 14- | xargs chmod -R +w && git clean -xfd
	@rm -rf /usr/local/include/github.com/InDebted/make
