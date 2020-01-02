include github.com/InDebted/make/debug

.PHONY: node_dependencies
node_dependencies: yarn.lock

yarn.lock: node_modules package.json
	$(call _info,Installing Node dependencies…)
	@rm -rf node_modules yarn.lock
	@npx yarn install

node_modules:; @mkdir -p $@
