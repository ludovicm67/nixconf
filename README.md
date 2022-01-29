# First setup

```sh
mkdir -p ~/.config/nix/
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
nix run '.#home-manager' -- switch --flake .
ln -s $(pwd) ~/.config/nixpkgs
```

On M1 MacOS:

```sh
echo "extra-platforms = aarch64-darwin x86_64-darwin" | sudo tee -a /etc/nix/nix.conf
```

# Update

```sh
nix flake update
home-manager switch
```

# Garbage collect

```sh
nix-collect-garbage # delete unreacheables derivations
nix-collect-garbage -d # delete also all old generations
```

# Troubleshooter

## The program 'nix' is currently not installed

This error can occur after upgrading the system.

Make sure the following lines are in the `/etc/zshrc` file:

```sh
# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix
```
