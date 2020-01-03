# Runs all tests for all modules
test:
	$(call _info,Testing…)
	@go test -count=1 $$(go list $$(ls -d */ | grep -v 'node_modules/' | awk '{print "./"$$0"..."}') 2>&1 | grep -v '^go: ')
.PHONY: test
