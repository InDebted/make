include github.com/InDebted/make/debug
SHELL := /usr/bin/env bash -eu -o pipefail -c
CPUS ?= $(shell (nproc --all || sysctl -n hw.ncpu) 2>/dev/null || echo 1)
CPUS := $(CPUS)
MAKEFLAGS += --jobs=$(CPUS)
MAKEFLAGS += --warn-undefined-variables
.POSIX:
.DELETE_ON_ERROR:
.SUFFIXES:

# Cleans up generated files
clean:
	$(call _info,Cleaning…)
	@rm -rf $(trash)
.PHONY: clean

# Cleans up the repository as if it was just cloned
clobber:
	$(call _info,Clobbering…)
	@git clean -xfdn | cut -c 14- | xargs chmod -R +w && git clean -xfd
.PHONY: clobber
