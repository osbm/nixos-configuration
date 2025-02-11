_default:
  @just --list --unsorted

check-git:
  # git must be clean
  test -z "$(git status --porcelain)"

[linux]
build *args: check-git
  sudo nixos-rebuild build --flake . {{args}} |& nom
  nvd diff /run/current-system ./result

[linux]
switch *args: check-git check
  sudo nixos-rebuild switch --accept-flake-config --flake . {{args}} |& nom

test:
  nh os test .

update:
  nix flake update

check:
  nix flake check

clean:
  rm result

collect-garbage:
  sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations old
  # home-manager expire-generations now
  sudo nix-collect-garbage --delete-older-than 3d

build-sd-image-harmonica: check-git
  nix build -L .#nixosConfigurations.harmonica.config.system.build.sdImage

build-iso: check-git
  nix build -L .#nixosConfigurations.myISO.config.system.build.isoImage
