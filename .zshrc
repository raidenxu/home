# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
if [ `hostname` = 'Odin-Pro.local' ]; then
    ZSH_THEME="odin"
else
    ZSH_THEME="odinman"
fi

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
#plugins=(git osx svn ccmd gnu-utils)
plugins=(git osx svn tmux zsh-vim-mode history-substring-search zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH="/opt/local/bin:/opt/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin:/usr/X11R6/bin:/Users/Odin/sbin:/services/hiphop-php/src/hphp:/services/hiphop-php/src/hphpi:/Applications/Xcode.app/Contents/Developer/usr/bin"

## zsh-syntax-highlighting configuration
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
# To have paths colored instead of underlined
ZSH_HIGHLIGHT_STYLES[path]='fg=blue'
ZSH_HIGHLIGHT_STYLES[command]='fg=yellow'

##for faster vim
if [ -e "/Applications/MacPorts/MacVim.app/Contents/MacOS/Vim" ]; then
    alias vim="/Applications/MacPorts/MacVim.app/Contents/MacOS/Vim"
    alias vi="vim" # using vim as PAGER(http://www.vim.org/scripts/script.php?script_id=1723)
    export PAGER="~/vim_setting/sbin/vimpager"
    alias less=$PAGER
elif [ -e `which vim` ]; then
    alias vi="vim" # using vim as PAGER(http://www.vim.org/scripts/script.php?script_id=1723)
    export PAGER="~/vim_setting/sbin/vimpager"
    alias less=$PAGER
fi
export EDITOR=vim

## self alias
alias tree='tree -C'

##Chinese support
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

##hiphop
export HPHP_HOME=/services/hiphop/hiphop-php
export HPHP_LIB=${HPHP_HOME}/bin
export CMAKE_PREFIX_PATH=/services/hiphop/local
export Boost_LIBRARYDIR=/services/hiphop/local/include/boost
export CC=/usr/bin/gcc
export CXX=/usr/bin/g++

export PATH=/services/hiphop/hiphop-php/src/hphp:/services/hiphop/hiphop-php/src/hhvm:$PATH
