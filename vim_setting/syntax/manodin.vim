" Vim syntax file
" Language:	Man page
" Maintainer:	Nam SungHyun <namsh@kldp.org>
" Previous Maintainer:	Gautam H. Mudunuri <gmudunur@informatica.com>
" Version Info:
" Last Change:	2007 Dec 30

" Additional highlighting by Johannes Tanzler <johannes.tanzler@aon.at>:
"	* manSubHeading
"	* manSynopsis (only for sections 2 and 3)

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Get the CTRL-H syntax to handle backspaced text
if version >= 600
  runtime! syntax/ctrlh.vim
else
  source <sfile>:p:h/ctrlh.vim
endif

syn case ignore
syn match  manReference       "\f\+([1-9][a-z]\=)"
syn match  manTitle	      "^\f\+([0-9]\+[a-z]\=).*"
syn match  manSectionHeading  "^[a-z][a-z ]*[a-z]$"
syn match  manSubHeading      "^\s\{3\}[a-z][a-z ]*[a-z]$"
syn match  manOptionDesc      "^\s*[+-][a-z0-9]\S*"
syn match  manLongOptionDesc  "^\s*--[a-z0-9-]\S*"
" syn match  manHistory		"^[a-z].*last change.*$"

if getline(1) =~ '^[a-zA-Z_]\+([23])'
  syntax include @cCode <sfile>:p:h/c.vim
  syn match manCFuncDefinition  display "\<\h\w*\>\s*("me=e-1 contained
  syn region manSynopsis start="^SYNOPSIS"hs=s+8 end="^\u\+\s*$"me=e-12 keepend contains=manSectionHeading,@cCode,manCFuncDefinition
endif


" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_man_syn_inits")
  if version < 508
    let did_man_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink manTitle	    Title
  HiLink manSectionHeading  Statement
  HiLink manOptionDesc	    Constant
  HiLink manLongOptionDesc  Constant
  HiLink manReference	    PreProc
  HiLink manSubHeading      Function
  HiLink manCFuncDefinition Function

  delcommand HiLink
endif

" Odin's additional <man.vim> stuff
" copied from http://vim.wikia.com/wiki/Using_vim_as_a_man-page_viewer_under_Unix
syn match manSectionHeading "^\s\+[0-9]\+\.[0-9.]*\s\+[A-Z].*$" contains=manSectionNumber
syn match manSectionNumber "^\s\+[0-9]\+\.[0-9]*" contained
syn region manDQString start='[^a-zA-Z"]"[^", )]'lc=1 end='"' contains=manSQString
syn region manSQString start="[ \t]'[^', )]"lc=1 end="'"
syn region manSQString start="^'[^', )]"lc=1 end="'"
syn region manBQString start="[^a-zA-Z`]`[^`, )]"lc=1 end="[`']"
syn region manBQSQString start="``[^),']" end="''"
syn match manBulletZone transparent "^\s\+o\s" contains=manBullet
syn case match
syn keyword manBullet contained o
syn match manBullet contained "\[+*]"
syn match manSubSectionStart "^\*" skipwhite nextgroup=manSubSection
syn match manSubSection ".*$" contained

" added by odin for 全角
syn region manBQSQString start="“[^),']" end="”"
syn region manBQString start="[^a-zA-Z‘]‘[^‘, )]"lc=1 end="’"

hi link manSectionNumber Number
hi link manDQString String
hi link manSQString String
hi link manBQString String
hi link manBQSQString String
hi link manBullet Special
hi manSubSectionStart term=NONE cterm=NONE gui=NONE ctermfg=black ctermbg=black guifg=navyblue guibg=navyblue
hi manSubSection term=underline cterm=underline gui=underline ctermfg=green guifg=green

let b:current_syntax = "manodin"

" vim:ts=8 sts=2 sw=2:
