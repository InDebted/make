.tmp/gomod.log: go.mod go.sum
	$(call _info,Downloading go modules…)
	@mkdir -p $(dir $@)
	@go mod download | tee $@

go-modules: .tmp/gomod.log
.PHONY: go-modules