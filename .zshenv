if [[ -d $HOME/.cargo/ ]]; then
  . "$HOME/.cargo/env"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# rust path
export PATH="${HOME}/bin:${PATH}"
export PATH=$HOME/.cargo/bin:$PATH

# ruby path
export PATH=$HOME/.rbenv/bin:$PATH
export PATH=$PATH:/usr/local/go/bin

export PATH="$HOME/.luarocks/bin:$PATH"

export PATH="$HOME/go/bin:$PATH"
export PATH="/usr/local/bin:$PATH"


export PYTHONPATH="$HOME/bin/8ucchiman/python/8ucchiman.zip:$HOME/.config/lib/python:$HOME/.config/pockets/python:$HOME/.config/pockets/python:$PYTHONPATH"
# export LD_LIBRARY_PATH="/usr/include/opencv4:$HOME/.config/pockets/c/lib:$LD_LIBRARY_PATH"
export PATH="/usr/include/opencv4:$PATH"

# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/targets/x86_64-linux/lib:/usr/local/cuda-12/targets/x86_64-linux/lib/:/usr/local/cuda-11.7

export PATH="/usr/local/cuda/bin:$PATH"

export PATH="$PATH:$HOME/.dotnet:$HOME/.dotnet/tools"
export PATH="$PATH:$HOME/.luarocks/bin"
export PATH="$PATH:$HOME/.local/bin"
#zmodload zsh/zprof && zprof
export LUA_PATH="$HOME/.config/pockets/lua/?.lua;$LUA_PATH"


export FPATH="$FPATH:$HOME/.config/pockets/shell"

# Codon compiler path (added by install script)
export PATH=/home/yk.iwabuchi/.codon/bin:$PATH

export PATH=$HOME/bin:$HOME/bin/8ucchiman/:$PATH
export PATH=/snap/bin:$PATH
export PATH=/opt/local/share/dotnet:$PATH
export DOTNET_ROOT=/usr/local/share/dotnet/shared

if [ -e /home/bucchiman/.nix-profile/etc/profile.d/nix.sh ]; then . /home/bucchiman/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

if [ -e /home/yk.iwabuchi/.nix-profile/etc/profile.d/nix.sh ]; then . /home/yk.iwabuchi/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# Reference: https://bakkyalo.hatenablog.jp/entry/2023/06/14/015223
export PKG_CONFIG_PATH="/opt/local/lib/opencv4/pkgconfig"

export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

export PICO_SDK_PATH=$HOME/source/pico-sdk
