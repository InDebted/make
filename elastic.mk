export ELASTICSEARCH_URL ?= http://elasticsearch:9200

# Wait for Elastic Search to be up
elastic.is-up:
	@$(call _info,Waiting for Elastic Search…)
	@dockerize -wait ${ELASTICSEARCH_URL}/_cat/health -timeout 60s
.PHONY: elastic.is-up
