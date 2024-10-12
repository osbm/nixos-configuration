

check-status:
	@if [ -n "$$(git status --porcelain)" ]; then \
		echo "Error: You have untracked or modified files. Please commit or stash your changes."; \
		exit 1; \
	fi
	echo Git is clean. :)

build: check-status
	NIXOS_LABEL := $(shell git rev-parse HEAD)
	sudo nixos-rebuild switch --flake .
