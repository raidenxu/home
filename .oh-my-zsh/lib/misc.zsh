## smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

## file rename magick
bindkey "^[m" copy-prev-shell-word

## jobs
setopt long_list_jobs

## pager
if [ -e `which vim` ]; then
    alias vi='vim'
    # using vim as PAGER(http://www.vim.org/scripts/script.php?script_id=1723)
    export PAGER="~/vim_setting/sbin/vimpager"
    alias less=$PAGER
else
    export PAGER="less"
    export LESS="-R"
fi

#export LC_CTYPE=$LANG

##env
export EDITOR=vim

##Chinese support
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
