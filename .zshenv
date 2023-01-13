. "$HOME/.cargo/env"
PATH="$HOME/.cargo/bin:$PATH"

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

#zmodload zsh/zprof && zprof
