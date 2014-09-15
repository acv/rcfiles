set nocompatible
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
syntax on
set ai
set cindent
colorscheme desert
if $_ != '/usr/bin/vi'
  set relativenumber
endif
set guioptions-=T
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
set laststatus=2
set showcmd
set noerrorbells
set visualbell
set hlsearch
set bs=2

" Disable middle button paste
nnoremap <MiddleMouse> <Nop>
nnoremap <2-MiddleMouse> <Nop>
nnoremap <3-MiddleMouse> <Nop>
nnoremap <4-MiddleMouse> <Nop>

inoremap <MiddleMouse> <Nop>
inoremap <2-MiddleMouse> <Nop>
inoremap <3-MiddleMouse> <Nop>
inoremap <4-MiddleMouse> <Nop>

let mapleader = ","
" toggle between number and relative number on ,l
nnoremap <leader>l :call ToggleRelativeAbsoluteNumber()<CR>
function! ToggleRelativeAbsoluteNumber()
  if &number
    set relativenumber
  else
    set number
  endif
endfunction

if !exists("*TagInStatusLine")
  function TagInStatusLine()
    return ''
  endfunction
endif

runtime plugin/syntastic.vim
if !exists("*SyntasticStatuslineFlag")
  function! SyntasticStatuslineFlag()
    return ''
  endfunction
endif

if !exists("*haslocaldir")
  function! HasLocalDir()
    return ''
  endfunction
else
  function! HasLocalDir()
    if haslocaldir()
      return '[lcd]'
    endif
    return ''
  endfunction
endif


set statusline=                 " my status line contains:
set statusline+=%n:             " - buffer number, followed by a colon
set statusline+=%<%f            " - relative filename, truncated from the left
set statusline+=\               " - a space
set statusline+=%h              " - [Help] if this is a help buffer
set statusline+=%m              " - [+] if modified, [-] if not modifiable
set statusline+=%r              " - [RO] if readonly
set statusline+=%2*%{HasLocalDir()}%*           " [lcd] if :lcd has been used
set statusline+=%#warningmsg#%{SyntasticStatuslineFlag()}%*
set statusline+=\               " - a space
set statusline+=%1*%{TagInStatusLine()}%*       " [current class/function]
set statusline+=\               " - a space
set statusline+=%=              " - right-align the rest
set statusline+=%-10.(%l,%c%V%) " - line,column[-virtual column]
set statusline+=\               " - a space
set statusline+=%4L             " - total number of lines in buffer
set statusline+=\               " - a space
set statusline+=%P              " - position in buffer as percentage

highlight LineNr ctermfg=grey ctermbg=black guibg=black guifg=MediumPurple
highlight Normal guibg=grey5

if has("gui_running")
    set transparency=5
    set antialias
    set guifont=Monaco:h12.00
endif

" TagList Plugin Configuration
let Tlist_Ctags_Cmd='/usr/local/bin/ctags' " point taglist to ctags
let Tlist_GainFocus_On_ToggleOpen = 1      " Focus on the taglist when its toggled
let Tlist_Close_On_Select = 1              " Close when something's selected
let Tlist_Use_Right_Window = 0             " Project uses the left window
let Tlist_File_Fold_Auto_Close = 1         " Close folds for inactive files
nnoremap <leader>m :TlistToggle<CR>

" Viewport Controls
" ie moving between split panes
nnoremap <silent><leader>h <C-w>h 
nnoremap <silent><leader>j <C-w>j
nnoremap <silent><leader>k <C-w>k
nnoremap <silent><leader>l <C-w>l
nnoremap <silent><leader><left> <C-w>h 
nnoremap <silent><leader><down> <C-w>j
nnoremap <silent><leader><up> <C-w>k
nnoremap <silent><leader><right> <C-w>l

" NERDtree
nnoremap <silent><leader>n :NERDTreeToggle<CR>
" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1
" Don't display these kinds of files
let NERDTreeIgnore=[ '\.o$', '\.pyo$', '\.pyc$', '\.prof$', '\.dylib$', '\.a$', '\.lo$', '\.la$' ]
let NERDChristmasTree=1
let NERDTreeWinPos='right'

" Ack plugin
nnoremap <leader>a :Ack! 
nnoremap <silent> <leader>? :execute "Ack! '" . substitute(substitute(substitute(@/, "\\\\<", "\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "", "") . "'"<CR>

nnoremap <leader>p :RainbowParenthesesToggle<CR>
nnoremap <leader>o :RainbowParenthesesLoadChevron<CR>

au Syntax * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
"au Syntax * RainbowParenthesesLoadChevron

autocmd FileType python set omnifunc=pythoncomplete#Complete
inoremap <C-space> <C-x><C-o>
filetype plugin indent on

au BufNewFile,BufRead *.yml set filetype=ansible
