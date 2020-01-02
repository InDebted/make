docker-compose := $(shell which docker-compose)

define docker
	@[[ -f /.dockerenv ]] && eval "$(1)" || \
		$(docker-compose) run --rm -u $$(id -u):$$(id -g) golang /bin/bash -eu -o pipefail -c "$(1)"
endef
