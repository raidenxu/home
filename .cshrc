# $FreeBSD: src/share/skel/dot.cshrc,v 1.13 2001/01/10 17:35:28 archie Exp $
#
# .cshrc - csh resource script, read at beginning of execution by each shell
#
# see also csh(1), environ(7).
#

alias h		history 25
alias j		jobs -l
alias la	ls -a
alias lf	ls -FA
alias ll	ls -lA
##colorful grep...
alias grep  grep --color=auto -d skip

# A righteous umask
umask 2

set path = (/sbin /bin /usr/sbin /usr/bin /usr/games /usr/local/sbin /usr/local/bin /usr/X11R6/bin $HOME/sbin /services/hiphop-php/src/hphp /services/hiphop-php/src/hphpi)

setenv	EDITOR	vim
setenv	BLOCKSIZE	K
##Chinese support
setenv  LANG    en_US.UTF-8
setenv  LC_ALL  en_US.UTF-8

## 如果安装了vim
if (-e `which vim`) then
    alias vi    vim
    # using vim as PAGER(http://www.vim.org/scripts/script.php?script_id=1723)
    setenv  PAGER   ~/vim_setting/sbin/vimpager 
    alias   less    $PAGER
else
    setenv  PAGER   less
endif

##odin's setting
setenv LSCOLORS ExGxFxdxCxegedabagacad 
setenv CLICOLOR yes
set prompt = "%B%{\033[34m%}[%{\033[36m%}%n%{\033[34m%}@%{\033[33m%}%m %{\033[32m%}%c%{\033[34m%}]%{\033[35m%}%#%b"
set autolist
#set autocorrect = ambiguous
#set complete = completion 1
#set correct = all

if ($?prompt) then
	# An interactive shell -- set some stuff up
	set filec
	set history = 1000
	set savehist = 500
	set mail = (/var/mail/$USER)
	if ( $?tcsh ) then
		bindkey "^W" backward-delete-word
        bindkey "^R" i-search-back
		bindkey "^b" backward-word
		bindkey -k up history-search-backward
		bindkey -k down history-search-forward
	endif
endif

##256 color
setenv TERMCAP 'xterm|xterm-color:Co#256:AB=\E[48;5;%dm:AF=\E[38;5;%dm:ti@:te@:tc=xterm-256color:'

##for hadoop
setenv  JAVA_HOME   /usr/local/jdk1.6.0
setenv  CLASSPATH   ".:/usr/local/jdk1.6.0/lib"
setenv  ANT_OPTS   "-Djava.net.preferIPv4Stack=true"

##hiphop for php
setenv HPHP_HOME /services/hiphop-php
setenv HPHP_LIB ${HPHP_HOME}/bin
setenv CMAKE_PREFIX_PATH /services/hipop-php-include
setenv CC /usr/local/bin/gcc44
setenv CXX /usr/local/bin/g++44
