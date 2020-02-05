SHELL := /usr/bin/env bash -eu -o pipefail -c
CPUS ?= $(shell (nproc --all || sysctl -n hw.ncpu) 2>/dev/null || echo 1)
CPUS := $(CPUS)
MAKEFLAGS += --jobs=$(CPUS)
MAKEFLAGS += --warn-undefined-variables
MAKEFILE_PRINT ?= true
.POSIX:
.DELETE_ON_ERROR:
.SUFFIXES:
.DEFAULT_GOAL := build

include github.com/InDebted/make/_git
include github.com/InDebted/make/_debug
include github.com/InDebted/make/_gomod
include github.com/InDebted/make/_node
include github.com/InDebted/make/_docker
include github.com/InDebted/make/build
include github.com/InDebted/make/clean
include github.com/InDebted/make/deploy
include github.com/InDebted/make/lint
include github.com/InDebted/make/test
include github.com/InDebted/make/precommit
