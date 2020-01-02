include github.com/InDebted/make/node
include github.com/InDebted/make/build

.PHONY: deploy

ifndef ENV
deploy:; $(error ENV environment variable is required)
deploy/%:; $(error ENV environment variable is required)
else

serverless-deploy := npx --no-install sls deploy --aws-s3-accelerate --conceal --verbose --stage $(ENV)

# Deploys all handlers to ENV
deploy: $(all_handlers) | node_dependencies
	$(call _info,Deploying $(notdir $(CURDIR)) to $(ENV) environment…)
	@$(serverless-deploy)

# Deploy specified handler to ENV
deploy/%: $(dist_dir)/% | node_dependencies
	$(call _info,Deploying $* to $(ENV) environment…)
	@$(serverless-deploy) --function $*

endif
