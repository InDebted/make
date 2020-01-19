# Runs all tests for all modules
test:
	$(call _info,Testing…)
	@go test -count=1 $$({\
		$(call git-ls,':(glob)*_test.go') | xargs test -z || echo . & \
		$(call git-ls,'**/*_test.go') | cut -d/ -f1 | uniq | awk '{print "./"$$0"/..."}' \
	;})
.PHONY: test
