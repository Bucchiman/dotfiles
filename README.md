# Snippets
You need the following packages to run snippets.

- neofetch
- fzf
- bat
- exa


## neofetch

## fzf
```zsh
    $ sudo apt install fzf      # Ubuntu
    $ sudo port install fzf     # Mac

    # Using git
    $ git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
    $ $HOME/.fzf/install
    $ ln -s $HOME/.fzf/bin/fzf $HOME/bin/fzf
```


## bat
```
    # Ubuntu
    $ sudo apt install bat
    $ mkdir -p $HOME/.local/bin
    $ ln -s /usr/bin/batcat $HOME/.local/bin/bat

    $ port install bat          # Mac

    # From Source
    $ cargo install --locked bat
```


## exa
