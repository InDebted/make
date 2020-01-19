docker-compose-service ?= dev

# Runs the given target (%) in docker
d.%:
	@[ -f /.dockerenv ] && mmake $* || docker-compose run --rm $(docker-compose-service) mmake $*