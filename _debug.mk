define _print
	@[ -z "${MAKEFILE_PRINT}" ] || printf "$(1)\n"
endef

define _info
	$(call _print,\033[36m[INFO]\033[0m\t$(1))
endef
