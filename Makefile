

check-status:
	@if [ -n "$$(git status --porcelain)" ]; then \
		echo "Error: You have untracked or modified files. Please commit or stash your changes."; \
		exit 1; \
	fi
	echo "Git is clean. :)"

build: check-status
	@NIXOS_LABEL=$$(git rev-parse HEAD) && \
	echo "Setting NixOS label to commit hash: $$NIXOS_LABEL" && \
	sudo nixos-rebuild switch --flake . --arg config "'{ system.label = \"$$NIXOS_LABEL\"; }'"


.PHONY: check-status build
