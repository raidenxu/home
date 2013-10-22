" Vim color file
" Maintainer:	Odin Lee <odinmanlee@gmail.com>
" Last Change:	2008 Oct 28
" grey on black
" optimized for TFT panels

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
"colorscheme default
let g:colors_name = "odinman"

if has("gui_running") || &t_Co == 88 || &t_Co == 256
  " functions {{{
  " returns an approximate grey index for the given grey level
  fun <SID>grey_number(x)
    if &t_Co == 88
      if a:x < 23
        return 0
      elseif a:x < 69
        return 1
      elseif a:x < 103
        return 2
      elseif a:x < 127
        return 3
      elseif a:x < 150
        return 4
      elseif a:x < 173
        return 5
      elseif a:x < 196
        return 6
      elseif a:x < 219
        return 7
      elseif a:x < 243
        return 8
      else
        return 9
      endif
    else
      if a:x < 14
        return 0
      else
        let l:n = (a:x - 8) / 10
        let l:m = (a:x - 8) % 10
        if l:m < 5
          return l:n
        else
          return l:n + 1
        endif
      endif
    endif
  endfun


  " returns the actual grey level represented by the grey index
  fun <SID>grey_level(n)
    if &t_Co == 88
      if a:n == 0
        return 0
      elseif a:n == 1
        return 46
      elseif a:n == 2
        return 92
      elseif a:n == 3
        return 115
      elseif a:n == 4
        return 139
      elseif a:n == 5
        return 162
      elseif a:n == 6
        return 185
      elseif a:n == 7
        return 208
      elseif a:n == 8
        return 231
      else
        return 255
      endif
    else
      if a:n == 0
        return 0
      else
        return 8 + (a:n * 10)
      endif
    endif
  endfun


  " returns the palette index for the given grey index
  fun <SID>grey_color(n)
    if &t_Co == 88
      if a:n == 0
        return 16
      elseif a:n == 9
        return 79
      else
        return 79 + a:n
      endif
    else
      if a:n == 0
        return 16
      elseif a:n == 25
        return 231
      else
        return 231 + a:n
      endif
    endif
  endfun


  " returns an approximate color index for the given color level
  fun <SID>rgb_number(x)
    if &t_Co == 88
      if a:x < 69
        return 0
      elseif a:x < 172
        return 1
      elseif a:x < 230
        return 2
      else
        return 3
      endif
    else
      if a:x < 75
        return 0
      else
        let l:n = (a:x - 55) / 40
        let l:m = (a:x - 55) % 40
        if l:m < 20
          return l:n
        else
          return l:n + 1
        endif
      endif
    endif
  endfun


  " returns the actual color level for the given color index
  fun <SID>rgb_level(n)
    if &t_Co == 88
      if a:n == 0
        return 0
      elseif a:n == 1
        return 139
      elseif a:n == 2
        return 205
      else
        return 255
      endif
    else
      if a:n == 0
        return 0
      else
        return 55 + (a:n * 40)
      endif
    endif
  endfun


  " returns the palette index for the given R/G/B color indices
  fun <SID>rgb_color(x, y, z)
    if &t_Co == 88
      return 16 + (a:x * 16) + (a:y * 4) + a:z
    else
      return 16 + (a:x * 36) + (a:y * 6) + a:z
    endif
  endfun


  " returns the palette index to approximate the given R/G/B color levels
  fun <SID>color(r, g, b)
    " get the closest grey
    let l:gx = <SID>grey_number(a:r)
    let l:gy = <SID>grey_number(a:g)
    let l:gz = <SID>grey_number(a:b)


    " get the closest color
    let l:x = <SID>rgb_number(a:r)
    let l:y = <SID>rgb_number(a:g)
    let l:z = <SID>rgb_number(a:b)


    if l:gx == l:gy && l:gy == l:gz
      " there are two possibilities
      let l:dgr = <SID>grey_level(l:gx) - a:r
      let l:dgg = <SID>grey_level(l:gy) - a:g
      let l:dgb = <SID>grey_level(l:gz) - a:b
      let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
      let l:dr = <SID>rgb_level(l:gx) - a:r
      let l:dg = <SID>rgb_level(l:gy) - a:g
      let l:db = <SID>rgb_level(l:gz) - a:b
      let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
      if l:dgrey < l:drgb
        " use the grey
        return <SID>grey_color(l:gx)
      else
        " use the color
        return <SID>rgb_color(l:x, l:y, l:z)
      endif
    else
      " only one possibility
      return <SID>rgb_color(l:x, l:y, l:z)
    endif
  endfun


  " returns the palette index to approximate the 'rrggbb' hex string
  fun <SID>rgb(rgb)
    let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
    let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
    let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0
    return <SID>color(l:r, l:g, l:b)
  endfun


  " sets the highlighting for the given group
  fun <SID>X(group, fg, bg, attr)
    if a:fg != ""
      exec "hi ".a:group." guifg=#".a:fg." ctermfg=".<SID>rgb(a:fg)
    endif
    if a:bg != ""
      exec "hi ".a:group." guibg=#".a:bg." ctermbg=".<SID>rgb(a:bg)
    endif
    if a:attr != ""
      if a:attr == 'italic'
        exec "hi ".a:group." gui=".a:attr." cterm=none"
      else
        exec "hi ".a:group." gui=".a:attr." cterm=".a:attr
      endif
    endif
  endfun
  " }}}


  call <SID>X('Normal',       'ffffff', '262626', 'none')   "(231) 正常输入
  call <SID>X('NonText',      'd7afaf', '2d2d2d', 'none')   "(181) 没有内容的区域
  call <SID>X('PreProc',      'd787af', '',       'none')   "(175) 预处理include,require等
  call <SID>X('Cursor',       '222222', 'ecee90', 'none')
  call <SID>X('CursorLine',   '',       '080808', 'none')   " 鼠标所在行
  call <SID>X('CursorColumn', '',       '080808', 'none')   " 鼠标所在列

  " Tab Menu
  call <SID>X('TabLineSel',   'ff8700', '',       '')       "(208)
  call <SID>X('TabLineFill',  '303030', '303030', '')       "(236,236)
  call <SID>X('TabLine',      '875f00', '303030', '')       "(94,236)

  "CursorIM
  "Question
  "IncSearch
  call <SID>X('Search',       '444444', 'af87d7', '')
  call <SID>X('MatchParen',   'ecee90', '857b6f', 'bold')
  call <SID>X('SpecialKey',   'd7afaf', '2d2d2d', 'none')   "(181) 
  call <SID>X('Visual',       'ecee90', '597418', 'none')
  call <SID>X('LineNr',       '857b6f', '121212', 'none')
  call <SID>X('Folded',       '87afff', '404048', 'none')   " 折叠
  call <SID>X('Title',        'f6f3e8', '',       'bold')
  call <SID>X('VertSplit',    '444444', '444444', 'none')
  call <SID>X('StatusLine',   '808080', '080808', 'italic')
  call <SID>X('StatusLineNC', '857b6f', '444444', 'none')
  "Scrollbar
  "Tooltip
  "Menu
  "WildMenu
  call <SID>X('Pmenu',        'f6f3e8', '444444', '')
  call <SID>X('PmenuSel',     '121212', 'caeb82', '')
  call <SID>X('WarningMsg',   'ff0000', '',       '')
  "ErrorMsg
  "ModeMsg
  "MoreMsg
  "Directory
  "DiffAdd
  "DiffChange
  "DiffDelete
  "DiffText


  " 语法高亮
  call <SID>X('Constant',     'd7005f', '',     'none')     "(161) 常数(__FILE__等)
  call <SID>X('String',       '87d700','080808','italic')   "(112) 字符串
  call <SID>X('Character',    '87d700','080808','italic')   "(112) 字母
  call <SID>X('Number',       '87d700','080808','none')     "(112) 数字(如果不设置,跟Constant)
  call <SID>X('Float',        '87d700','080808','none')     "(112) 浮点数字(如果不设置,跟Constant)
  call <SID>X('Boolean',      'd78787', '',     'none')     "(174) 布尔量,true false等，不设置跟Constant

  call <SID>X('Comment',      '767676', '',     'italic')   "(243) 注释


  call <SID>X('Keyword',      '5fff87', '',     'none')     "(84) 关键字
  call <SID>X('Label',        '00afff', '',     'none')     " 

  call <SID>X('Statement',    'd7ff00', '',     'none')     "(190) if else exit,empty,$ = : . 
  call <SID>X('Operator',     'd7af00', '',     'none')     "(178) $ 等，没设置就跟Statement
  call <SID>X('Conditional',  '5fff87', '',     'none')     "(84) if then else 等,没设置跟Statement
  call <SID>X('Repeat',       'ff8787', '',     'none')     "(210) foreach,while,没设置跟Statement
  call <SID>X('Function',     '00afff', '',     'none')     "(39) 内置函数名
  call <SID>X('Identifier',   '5f5fff', '',     'none')     "(63) 变量名
  call <SID>X('Define',       'cd5c5c', '',     'none')     "定义关键字,如function等


  call <SID>X('Type',         'ff5f00', '',     'none')     "(202) 类型 int,array,null,date等
  call <SID>X('StorageClass', 'd7afaf', '',     'none')     "(181) php的private,static等
  call <SID>X('Structure',    'ff5f00', '',     'none')     "(202) class ->
  call <SID>X('Typedef',      'ff5f00', '',     'none')     "(202) 
  call <SID>X('Include',      'd7af87', '',     'italic')   "(180) include,require

  call <SID>X('Delimiter',    'd700ff', '',     'none')     "(196,232) 括号等 {} () []
  call <SID>X('Special',      'd700ff', '',     'none')     "(165) 括号等 {} () []
  call <SID>X('SpecialChar',  'ff0000','080808','none')     "(196,232) hex, ocatal \n etc.

  call <SID>X('Todo',         '857b6f', '',     'italic')
  "Underlined
  "Error
  "Ignore


  hi! link VisualNOS  Visual
  "hi! link NonText  LineNr
  hi! link FoldColumn Folded


  " delete functions {{{
  delf <SID>X
  delf <SID>rgb
  delf <SID>color
  delf <SID>rgb_color
  delf <SID>rgb_level
  delf <SID>rgb_number
  delf <SID>grey_color
  delf <SID>grey_level
  delf <SID>grey_number
  " }}}

else
  """""""""""""""""""""""""""""""""
  " VIM
  """""""""""""""""""""""""""""""""
  hi TabLine    cterm=NONE ctermfg=LightGrey ctermbg=DarkGrey  gui=NONE guifg=Red guibg=white
  hi TabLineSel cterm=NONE ctermfg=Cyan  gui=NONE guifg=Red guibg=white
  hi TabLineFill  cterm=NONE  ctermbg=DarkGrey  gui=NONE  guibg=white
  "vim状态行
  "hi StatusLine cterm=NONE ctermfg=LightGrey ctermbg=DarkGrey  gui=NONE guifg=Red guibg=white
  hi StatusLine cterm=NONE ctermfg=LightGrey ctermbg=Black gui=NONE guifg=Red guibg=white

  """""""""""""""""""""""""""""""""""""""""""""
  "syntax
  """""""""""""""""""""""""""""""""""""""""""""
  "hi Normal     ctermfg=LightGrey	ctermbg=Black
  "普通内容

  "搜索到内容
  "hi Search     cterm=NONE ctermfg=Black	ctermbg=Red gui=NONE guifg=Black guibg=Red

  "在visual模式时
  "hi Visual     cterm=reverse gui=reverse
  hi Visual        cterm=reverse
  "hi Visual     cterm=bold,underline

  hi Cursor     cterm=bold ctermfg=Black ctermbg=Green  gui=bold guifg=Black guibg=Green

  "括号等
  hi Special    cterm=NONE ctermfg=DarkMagenta  gui=NONE guifg=DarkMagenta

  "注释
  hi Comment    cterm=NONE ctermfg=DarkGray     gui=NONE guifg=DarkGray

  "if,else等
  "hi Statement  cterm=NONE ctermfg=Brown  gui=NONE guifg=Brown 
  hi Statement  cterm=NONE ctermfg=3  gui=NONE guifg=3

  "引号内容
  hi Constant   cterm=NONE ctermfg=Green gui=NONE guifg=Green
  "hi Constant   cterm=NONE ctermfg=DarkCyan   gui=NONE guifg=DarkCyan

  "变量名颜色
  hi Identifier cterm=NONE ctermfg=DarkCyan   gui=NONE guifg=DarkCyan
  "hi Identifier cterm=NONE ctermfg=LightGreen gui=NONE guifg=LightGreen

  "include,require等
  hi PreProc    cterm=NONE ctermfg=DarkRed    gui=NONE guifg=Red2

  "folding
  hi Folded     cterm=NONE  ctermfg=blue ctermbg=NONE gui=NONE guibg=grey30 guifg=gold
  hi FoldColumn cterm=NONE  ctermfg=blue ctermbg=NONE gui=NONE guibg=grey30 guifg=tan
endif
