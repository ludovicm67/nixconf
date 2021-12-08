# First setup

```sh
mkdir -p ~/.config/nix/
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
nix run '.#home-manager' -- switch --flake .
```

# Update

```sh
nix flake update
home-manager switch --flake .
```
