" Approximate Cursor / VS Code Default Dark Modern for terminal Vim.
" Leaves Normal background unset so Ghostty transparency/blur still shows through.

hi clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'dark-modern'

" Palette (from Default Dark Modern / Dark+)
" fg #CCCCCC  comment #6A9955  string #CE9178  keyword #569CD6
" number #B5CEA8  function #DCDCAA  type #4EC9B0  const #4FC1FF
" variable #9CDCFE  operator #D4D4D4  error #F14C4C  warn #CCA700
" selection #264F78  line #2B2B2B  cursorline #2A2A2A

hi Normal       guifg=#CCCCCC guibg=NONE
hi NonText      guifg=#3C3C3C guibg=NONE
hi Comment      guifg=#6A9955 gui=italic
hi Constant     guifg=#4FC1FF
hi String       guifg=#CE9178
hi Character    guifg=#CE9178
hi Number       guifg=#B5CEA8
hi Boolean      guifg=#569CD6
hi Float        guifg=#B5CEA8
hi Identifier   guifg=#9CDCFE
hi Function     guifg=#DCDCAA
hi Statement    guifg=#C586C0
hi Conditional  guifg=#C586C0
hi Repeat       guifg=#C586C0
hi Label        guifg=#C586C0
hi Operator     guifg=#D4D4D4
hi Keyword      guifg=#569CD6
hi Exception    guifg=#C586C0
hi PreProc      guifg=#C586C0
hi Include      guifg=#C586C0
hi Define       guifg=#C586C0
hi Macro        guifg=#C586C0
hi PreCondit    guifg=#C586C0
hi Type         guifg=#4EC9B0
hi StorageClass guifg=#569CD6
hi Structure    guifg=#4EC9B0
hi Typedef      guifg=#4EC9B0
hi Special      guifg=#D7BA7D
hi SpecialChar  guifg=#D7BA7D
hi Tag          guifg=#569CD6
hi Delimiter    guifg=#D4D4D4
hi SpecialComment guifg=#6A9955 gui=italic
hi Underlined   guifg=#4FC1FF gui=underline
hi Todo         guifg=#CCA700 guibg=NONE gui=bold
hi Error        guifg=#F14C4C guibg=NONE
hi ErrorMsg     guifg=#F14C4C guibg=NONE
hi WarningMsg   guifg=#CCA700
hi MatchParen   guifg=#FFFFFF guibg=#515C6A
hi Search       guifg=#FFFFFF guibg=#613214
hi IncSearch    guifg=#FFFFFF guibg=#515C6A
hi Visual       guibg=#264F78
hi CursorLine   guibg=#2A2A2A
hi CursorColumn guibg=#2A2A2A
hi CursorLineNr guifg=#CCCCCC gui=bold
hi LineNr       guifg=#6E7681
hi SignColumn   guifg=#6E7681 guibg=NONE
hi VertSplit    guifg=#2B2B2B guibg=NONE
hi StatusLine   guifg=#CCCCCC guibg=#2B2B2B gui=NONE
hi StatusLineNC guifg=#6E7681 guibg=#2B2B2A gui=NONE
hi Pmenu        guifg=#CCCCCC guibg=#2B2B2B
hi PmenuSel     guifg=#FFFFFF guibg=#094771
hi PmenuSbar    guibg=#2B2B2B
hi PmenuThumb   guibg=#6E7681
hi TabLine      guifg=#6E7681 guibg=#2B2B2B gui=NONE
hi TabLineFill  guifg=#6E7681 guibg=#2B2B2B gui=NONE
hi TabLineSel   guifg=#FFFFFF guibg=#1F1F1F gui=NONE
hi DiffAdd      guifg=#89D185 guibg=#1F1F1F
hi DiffChange   guifg=#CCA700 guibg=#1F1F1F
hi DiffDelete   guifg=#F14C4C guibg=#1F1F1F
hi DiffText     guifg=#FFFFFF guibg=#264F78
hi Folded       guifg=#6E7681 guibg=#2B2B2B
hi FoldColumn   guifg=#6E7681 guibg=NONE
hi Directory    guifg=#569CD6
hi Title        guifg=#569CD6 gui=bold
hi WildMenu     guifg=#FFFFFF guibg=#094771
hi Question     guifg=#89D185
hi MoreMsg      guifg=#89D185
hi ModeMsg      guifg=#CCCCCC
hi SpellBad     guisp=#F14C4C gui=undercurl
hi SpellCap     guisp=#CCA700 gui=undercurl
hi SpellRare    guisp=#C586C0 gui=undercurl
hi SpellLocal   guisp=#4EC9B0 gui=undercurl

" Language links commonly used by Vim's syntax packs
hi link htmlTag         Tag
hi link htmlEndTag      Tag
hi link htmlTagName     Keyword
hi link cssClassName    Function
hi link cssIdentifier   Type
hi link jsFunction      Keyword
hi link jsFuncCall      Function
hi link typescriptBraces Delimiter
