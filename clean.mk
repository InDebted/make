# Cleans up generated files
clean:
	@$(call _info,Cleaning…)
	@rm -rf $(trash)
	@rm -rf package.tar.gz
.PHONY: clean

# Cleans up the repository as if it was just cloned
clobber:
	@$(call _info,Clobbering…)
	@git clean -xfdn | cut -c 14- | xargs chmod -R +w && git clean -xfd
.PHONY: clobber
