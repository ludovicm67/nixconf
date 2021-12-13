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
