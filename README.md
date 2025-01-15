# nixos is life
The nix configuration of mine. My intentions are just to maintain my configuration and to contribute to the nix community.

Here i have 4 machines.
- Laptop **tartarus** (faulty hardware, nvidia gpu doesnt work)
- Desktop **ymir** (beast, my most prized possesion as of now)
- Raspberry Pi 5 **pochita** (a server that i experiment with)
- Raspberry Pi 5 SD image **pochita-sd** (produces an sd image that could be used to flash the sd card of a rpi-5)

I didnt get these setup yet.
- Raspberry Pi Zero 2W **harmonica** (small machine for small tasks and cronjobs) (not setup yet)
- Android phone (termux) **android** (not setup yet)

# To-do list

- [ ] iso image generator for nixos
    - Basically the original nixos iso with added packages and tweaks.
- [ ] build custom android rom
    - Or how to run nixos on the phone.
- [ ] build android apps using nix
    - [ ] lichess
    - [ ] termux
- [ ] build my qmk keyboard with nix
- agenix
    - [ ] add my gpg keys
    - [x] add ssh keys so that machines can connect to each other
- [x] module system with options
- [ ] see which derivations will be built and which will be downloaded from cache or which is already present in the nix store.
- [ ] see which python packages are giving build errors.
- [x] home-manager setup
- [ ] make a development environment nix repository

