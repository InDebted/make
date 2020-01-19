serverless-deploy := npx --no-install sls deploy --aws-s3-accelerate --conceal --verbose --stage $(ENV)

# Deploys all handlers to ENV
deploy: $(all_handlers) | node-modules
	$(if $(ENV),,$(error ENV environment variable is required))

	@$(call _info,Deploying $(notdir $(CURDIR)) to $(ENV) environment…)
	@$(serverless-deploy)
.PHONY: deploy

# Deploy specified handler to ENV
deploy/%: $(dist_dir)/% | node-modules
	$(if $(ENV),,$(error ENV environment variable is required))

	@$(call _info,Deploying $* to $(ENV) environment…)
	@$(serverless-deploy) --function $*
.PHONY: deploy/%
