" don't bother with vi compatibility
set nocompatible

" enable syntax highlighting
syntax enable

set runtimepath+=$ODEVROOT/git/github/vim-golang

" configure Vundle
filetype on " without this vim emits a zero exit status, later, because of :ft off
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" install Vundle bundles
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
  source ~/.vimrc.bundles.local
endif

" ensure ftdetect et al work by including this after the Vundle stuff
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => system inv
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shell=zsh
set ambiwidth=double

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => indent
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab                                                " 在输入 tab 后, vim 用恰当的空格来填充这个 tab.
set shiftwidth=4                                             " 设置自动缩进 4 个空格
set softtabstop=4                                            " insert mode tab and backspace use 2 spaces
set tabstop=8                                                " 实际的 tab 即为 8 个空格, tabstop = 4 is better for c programming
set autoindent                                               "Auto indent
set smartindent                                              "Smart indet
"set cindent                                                 "C-style indenting
"set cino=:0g0t0(sus                                         " values control how cindent indent code
set wrap                                                     "Wrap line

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => encoding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let &termencoding = &encoding
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,cp936,big5,euc-jp,euc-kr,latin1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim ui
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hidden                                                   " switch buffers without save
set cursorline
set cursorcolumn
set autoread                                                 " reload files when changed on disk, i.e. via `git checkout`
set backspace=2                                              " Fix broken backspace in some setups
set backupcopy=yes                                           " see :help crontab
set clipboard=unnamed                                        " yank and paste with the system clipboard
set directory-=.                                             " don't store swapfiles in the current directory
set ignorecase                                               " case-insensitive search
set laststatus=2                                             " always show statusline
set nolist                                                     " show trailing whitespace
set listchars=tab:▸\ ,trail:▫
set ruler                                                    " show where you are
set scrolloff=3                                              " show context above/below cursorline
set smartcase                                                " case-sensitive search if any caps
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmenu                                                 " show a navigable menu for tab completion
set wildmode=longest,list,full
set pastetoggle=<F3>                                         " 切换paste模式
set number                                                   " show line numbers
set cmdheight=1                                              " The commandbar is 2 high
set whichwrap+=b,s,<,>,[,],h,l                               " Bbackspace and cursor keys wrap to
set incsearch                                                " 随打随找
set hlsearch                                                 " highlight search content
set showmatch                                                " show matching bracet
set matchtime=5                                              " show matching time
set mat=3                                                    " How many tenths of a second to blink
set formatoptions=tcrqmB
set splitbelow
set nostartofline
set showcmd                                                  " display incomplete command
set showmode                                                 " show editor mode, such as command, insert or replace, visual as messa
set confirm                                                  " with dialog support confirm({msg} [, {choices} [, {default} [, {type}]]])

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
colors solarized

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fileformat
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set fileformats=unix,dos
let g:explHideFiles='^\.,\.com$,\.doc$,\.pdf$,\.dvi$,\.gz$,\.exe$,\.zip$ \.ps$,\.ppt$'

" Enable basic mouse behavior such as resizing buffers.
"set mouse=a
if exists('$TMUX')  " Support resizing in tmux
  set ttymouse=xterm2
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Statusline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
function! CurDir()
    let curdir = substitute(getcwd(), '/home/odin/', "~/", "g")
    return curdir
endfunction
"Format the statusline
set statusline=
set statusline+=%f                              " path to the file in the buffer, relative to current directory
set statusline+=\ [%{strlen(&ft)?&ft:'none'},   " filetype
set statusline+=%{&encoding},                   " encoding
set statusline+=%{&fileformat}]                 " file format
set statusline+=\ (%l,%c)                       " 显示行数,列数
set statusline+=\ %r%{CurDir()}%h               " 显示当前目录
set statusline+=\ %h%1*%m%r%w%0*                " flag


""""""""""""""""""""""""""""""
" => Folding
""""""""""""""""""""""""""""""
set foldenable
set foldlevel=0
set foldmethod=marker
set foldlevelstart=-1
function! Fold()
  setl foldmethod=marker
  setl foldlevelstart=1
  syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend
  syn match foldImports /\(\n\?import.\+;\n\)\+/ transparent fold

  function! MyFoldText()
    "return substitute(getline(v:foldstart), '{.*', '{...}', '')
    return v:folddashes.substitute(getline(v:foldstart),'/\\*\\\|\\*/\\\|{{{\\d\\=','','g')
  endfunction
  setl foldtext=MyFoldText()
  set foldtext=v:folddashes.substitute(getline(v:foldstart),'/\\*\\\|\\*/\\\|{{{\\d\\=','','g')
endfunction

" => General Abbrevs
iab odate <c-r>=strftime("%Y%m%d%H%M")<cr>
iab owdate <c-r>=strftime("%Y-%m-%d %H:%M:%S")<cr>


""""""""""""""""""""""""""""""
" => Filetype generic
""""""""""""""""""""""""""""""
  autocmd FileType xhtml,html,python,vim,javascript,sql setl shiftwidth=2    " (setl)仅对当前buffer生效
  autocmd FileType xhtml,html,python,vim,javascript,sql setl tabstop=2
  autocmd FileType text setlocal textwidth=78                   " For all text files set 'textwidth' to 78 characters.

  """"""""""""""""""""""""""""""
  " HTML related
  """"""""""""""""""""""""""""""
  " HTML entities - used by xml edit plugin
  let xml_use_xhtml = 1
  "let xml_no_auto_nesting = 1

  "To HTML
  let html_use_css = 1
  let html_number_lines = 0
  let use_xhtml = 1

  """"""""""""""""""""""""""""""
  " nginx configuration
  """"""""""""""""""""""""""""""
  autocmd BufRead,BufNewFile nginx.conf,madengine.conf set filetype=nginx

  """"""""""""""""""""""""""""""
  " Ruby & PHP section
  """"""""""""""""""""""""""""""
  autocmd BufNewFile,BufRead *.m   setlocal filetype=php       " .m is php
  autocmd BufNewFile *.m,*.php 0r ~/.vim/skeleton/skeleton.php
  autocmd FileType ruby map <buffer> <leader><space> :w!<cr>:!ruby %<cr>
  autocmd FileType php compiler php
  autocmd FileType php map <buffer> <leader><space> <leader>cd:w<cr>:make %<cr>
  "autocmd FileType php call Fold()
  "autocmd FileType php setl fen
  "let php_sql_query=1
  "let php_htmlInStrings=1
  "let php_folding=1
  "let php_noShortTags=1

  """"""""""""""""""""""""""""""
  " Golang section
  """"""""""""""""""""""""""""""
  autocmd BufNewFile,BufRead *.go   setlocal filetype=go       " .go is go


  """"""""""""""""""""""""""""""
  " Python section
  """"""""""""""""""""""""""""""
  "Run the current buffer in python - ie. on leader+space
  autocmd FileType python so ~/.vim/syntax/python.vim
  autocmd FileType python map <buffer> <leader><space> :w!<cr>:!python %<cr>
  autocmd FileType python so ~/.vim/plugin/python_fold.vim

  "Set some bindings up for 'compile' of python
  autocmd FileType python set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
  autocmd FileType python set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

  "Python iMaps
  autocmd FileType python set cindent
  autocmd FileType python inoremap <buffer> $r return
  autocmd FileType python inoremap <buffer> $s self
  autocmd FileType python inoremap <buffer> $c ##<cr>#<space><cr>#<esc>kla
  autocmd FileType python inoremap <buffer> $i import
  autocmd FileType python inoremap <buffer> $p print
  autocmd FileType python inoremap <buffer> $d """<cr>"""<esc>O

  "Run in the Python interpreter
  function! Python_Eval_VSplit() range
   let src = tempname()
   let dst = tempname()
   execute ": " . a:firstline . "," . a:lastline . "w " . src
   execute ":!python " . src . " > " . dst
   execute ":pedit! " . dst
  endfunction
  autocmd FileType python vmap <F7> :call Python_Eval_VSplit()<cr>

  """""""""""""""""""""""""""""""
  " Vim section
  """""""""""""""""""""""""""""""
  autocmd FileType vim map <buffer> <leader><space> :w!<cr>:source %<cr>
  autocmd FileType vim set nofen

  """""""""""""""""""""""""""""""
  " Java section
  """""""""""""""""""""""""""""""
  autocmd FileType java inoremap <buffer> <C-t> System.out.println();<esc>hi

  "Java comments
  autocmd FileType java source ~/.vim/macros/jcommenter.vim
  autocmd FileType java let b:jcommenter_class_author='Odin Lee (odin@madhouse-inc.com)'
  autocmd FileType java let b:jcommenter_file_author='Odin Lee (odin@madhouse-inc.com)'
  autocmd FileType java map <buffer> <F2> :call JCommentWriter()<cr>

  "Abbr'z
  autocmd FileType java inoremap <buffer> $pr private
  autocmd FileType java inoremap <buffer> $r return
  autocmd FileType java inoremap <buffer> $pu public
  autocmd FileType java inoremap <buffer> $i import
  autocmd FileType java inoremap <buffer> $b boolean
  autocmd FileType java inoremap <buffer> $v void
  autocmd FileType java inoremap <buffer> $s String

  autocmd FileType java call Fold()
  "autocmd FileType java setl fen

  autocmd BufEnter *.sablecc,*.scc set ft=sablecc

  """"""""""""""""""""""""""""""
  " JavaScript section
  """""""""""""""""""""""""""""""
  autocmd FileType javascript call Fold()
  "autocmd FileType javascript setl fen

  autocmd FileType javascript imap <c-t> console.log();<esc>hi
  autocmd FileType javascript imap <c-a> alert();<esc>hi
  autocmd FileType javascript setl nocindent
  autocmd FileType javascript inoremap <buffer> $r return

  autocmd FileType javascript inoremap <buffer> $d //<cr>//<cr>//<esc>ka<space>
  autocmd FileType javascript inoremap <buffer> $c /**<cr><space><cr>**/<esc>ka

  """"""""""""""""""""""""""""""
  " HTML
  """""""""""""""""""""""""""""""
  autocmd FileType html,cheetah set ft=xml
  autocmd FileType html,cheetah set syntax=html

  """"""""""""""""""""""""""""""
  " C mappings
  """""""""""""""""""""""""""""""
  autocmd FileType c map <buffer> <leader><space> :w<cr>:!gcc %<cr>

  """"""""""""""""""""""""""""""
  " Scheme bidings
  """"""""""""""""""""""""""""""
  autocmd BufNewFile,BufRead *.scm map <buffer> <leader><space> <leader>cd:w<cr>:!petite %<cr>
  autocmd BufNewFile,BufRead *.scm inoremap <buffer> <C-t> (pretty-print )<esc>i
  autocmd BufNewFile,BufRead *.scm vnoremap <C-t> <esc>`>a)<esc>`<i(pretty-print <esc>

  """"""""""""""""""""""""""""""
  " MANPAGE section
  """""""""""""""""""""""""""""""
  autocmd FileType manodin setlocal laststatus=0

  " fdoc is yaml
  autocmd BufRead,BufNewFile *.fdoc set filetype=yaml
  " md is markdown
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  " extra rails.vim help
  autocmd User Rails silent! Rnavcommand decorator      app/decorators            -glob=**/* -suffix=_decorator.rb
  autocmd User Rails silent! Rnavcommand observer       app/observers             -glob=**/* -suffix=_observer.rb
  autocmd User Rails silent! Rnavcommand feature        features                  -glob=**/* -suffix=.feature
  autocmd User Rails silent! Rnavcommand job            app/jobs                  -glob=**/* -suffix=_job.rb
  autocmd User Rails silent! Rnavcommand mediator       app/mediators             -glob=**/* -suffix=_mediator.rb
  autocmd User Rails silent! Rnavcommand stepdefinition features/step_definitions -glob=**/* -suffix=_steps.rb
  " automatically rebalance windows on vim resize
  autocmd VimResized * :wincmd =


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:timestamp_regexp = '\v\C%(<%(Last %([cC]hanged?|modified)|Modified)\s*:\s*)@<=\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}%(\s+\a+)?'
let g:timestamp_rep = '%Y-%m-%d %H:%M:%S'
let g:timestamp_modelines = 12
let g:ctrlp_match_window = 'order:ttb,max:20'
let g:NERDSpaceDelims=1
let g:gitgutter_enabled = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => TOGGLE & Mapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" keyboard shortcuts
let mapleader = ','
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <leader>l :Align
nmap <leader>a :Ack 
nmap <leader>b :CtrlPBuffer<CR>
nmap <leader>d :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>
nmap <leader>t :CtrlP<CR>
nmap <leader>T :CtrlPClearCache<CR>:CtrlP<CR><CR>
nmap <leader>] :TagbarToggle<CR>
nmap <leader><space> :call whitespace#strip_trailing()<CR>
nmap <leader>g :GitGutterToggle<CR>
nmap <leader>c <Plug>Kwbd
nmap <leader>fd :se ff=dos<cr>
nmap <leader>fu :se ff=unix<cr>
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
" => Move a line of text using control
nmap <C-j> mz:m+<cr>`z
nmap <C-k> mz:m-2<cr>`z
vmap <C-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <C-k> :m'<-2<cr>`>my`<mzgv`yo`z

" plugin NERDTree
nmap <F1> :NERDTreeToggle<CR>

" 折叠命令
map <F5> zR
"map <F6> zO
"map <F7> zc
map <F8> zM
map <F9> <C-a>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc> "加()
vnoremap $2 <esc>`>a]<esc>`<i[<esc> "加[]
vnoremap $3 <esc>`>a}<esc>`<i{<esc> "加{}
vnoremap $$ <esc>`>a"<esc>`<i"<esc> "加""
vnoremap $q <esc>`>a'<esc>`<i'<esc> "加''

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map key to toggle opt
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function MapToggle(key, opt)
  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
  exec 'nnoremap '.a:key.' '.cmd
  exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command -nargs=+ MapToggle call MapToggle(<f-args>)
"MapToggle <F2> wrap
" 是否高亮搜索字符串
MapToggle <F2> hlsearch
" 切换大小写敏感
MapToggle <F4> ignorecase
MapToggle <F6> list
" Behavior-altering option toggles
MapToggle <F7> scrollbind

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('ag')
  let g:ackprg = 'ag --nogroup --column'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Use Ag over Grep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fix Cursor in TMUX
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
