define git-ls
	{ git ls-files $1 & git ls-files -o --exclude-standard $1; }
endef