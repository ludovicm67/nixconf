#/bin/zsh

export PATH="${PATH}:${HOME}/.krew/bin:/opt/homebrew/opt/libxml2/bin"
export EDITOR="vim"
export RPROMPT=""

export LDFLAGS="-L/opt/homebrew/opt/libxml2/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libxml2/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libxml2/lib/pkgconfig"
