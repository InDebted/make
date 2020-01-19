export DYNAMO_URL ?= http://dynamodb:8000

# Wait for Dynamo DB to be up
dynamo.is-up:
	@$(call _info,Waiting for Dynamo DB…)
	@dockerize -wait ${DYNAMO_URL}/shell/ -timeout 60s
.PHONY: dynamo.is-up
