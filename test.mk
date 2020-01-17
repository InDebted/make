# Runs all tests for all modules
test:
	$(call _info,Testing…)
	@go test -count=1 $$({\
		(test -z "$$(find . -maxdepth 1 -type f -name '*_test.go')" || echo .) & \
		{ git ls-files '**/*_test.go' & git ls-files -o --exclude-standard '**/*_test.go'; } | cut -d/ -f1 | uniq | awk '{print "./"$$0"/..."}' \
	;})
.PHONY: test
