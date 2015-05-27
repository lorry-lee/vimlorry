set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

" Make all map leaders use ;
" let mapleader = ","

" Share the clipboard with windows
set clipboard=unnamed

" Plugin manager -- pathogen
call pathogen#infect()

" Open the explorer tree
nmap <Leader>n :NERDTreeToggle<CR>
" Ignore pyc files
let NERDTreeIgnore = ['\.pyc$\|\.meta$']


" Set background as back
colo ayumi
" colo bandit
" colo diablo3

" Set no back up swap file
set nobackup

" Set tab as 4 space
set tabstop=4
set shiftwidth=4
set expandtab

" No Auto change line in txt file
set wrap
set linebreak
set nolist  " list disables linebreak
set formatoptions+=l

"autocmd Filetype cs setlocal ts=4 sw=4 sts=0 noexpandtab


" CtrlP settings
map <F3> :CtrlPMRUFiles<CR>
let g:ctrlp_cmd = 'CtrlP .'
let g:ctrlp_by_filename = 1
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|\.obj$\|\.pyc$\|\.meta$'
let g:ctrlp_root_markers = ['.ycm_extra_conf.py']
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_prompt_mappings = { 'PrtSelectMove("j")':   ['<c-n>', '<down>'], 'PrtSelectMove("k")':   ['<c-p>', '<up>'], 'PrtHistory(-1)':       ['<c-j>'], 'PrtHistory(1)':        ['<c-k>'], 'PrtClearCache()':      ['<F4>'], } 

" Taglist
" Open tag list selector
"map <S-o> :TlistToggle<CR>
map <S-o> :TagbarToggle<CR>
let g:Tlist_Ctags_Cmd='ctags.exe'
"For mac
"let g:Tlist_Ctags_Cmd='/usr/local/bin/ctags'
" Just display the current buffer's functions
let Tlist_Show_One_File = 1
" Show tag list on the right side
let Tlist_Use_Right_Window = 1

" Remap scroll up and scroll down
noremap <C-j> <C-e>
noremap <C-k> <C-y>

" Grep for search under specific folder or files
let Grep_Path = 'D:\Program Files\grep-2.5.4-bin\bin\grep.exe'
let Fgrep_Path = 'D:\Program Files\grep-2.5.4-bin\bin\fgrep.exe'
let Egrep_Path = 'D:\Program Files\grep-2.5.4-bin\bin\efgrep.exe'
let Grep_Find_Path = 'D:\Program Files\findutils-4.2.20-2-bin\bin\find.exe'
let Grep_Xargs_Path = 'D:\Program Files\findutils-4.2.20-2-bin\bin\xargs.exe'

" Remap to toggle qfix
map <C-F8> :QFix<CR>
map <F8> :cn<CR>
map <S-F8> :cp<CR>

nmap <Tab> <C-W><C-W>
nmap <A-k> :wincmd k<CR>
nmap <A-j> :wincmd j<CR>
nmap <A-h> :wincmd h<CR>
nmap <A-l> :wincmd l<CR>

" set encoding=utf-8

" Display line number
set number

" Set font to couriernew
set guifont=Bitstream_Vera_Sans_Mono:h10:cANSI
"set guifont=Lucida_Console:h11
"set guifont=monofur:h12

"Toggle Menu and Toolbar
set guioptions-=m
set guioptions-=T

" Don't need to hit enter
set cmdheight=3 lines=43

map <silent> <F9> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>

" Find current buffer in the NERD_Tree
map <Leader>g :NERDTreeFind<CR>

" Switch between cpp and h files
map <A-o> :A<CR>

" let ctags_path+="C:\Python26\Lib\site-packages\django\tags"

set completeopt=longest,menu " Don't display the preview window

" YouCompleteMe
nmap <C-]> :YcmCompleter GoTo<CR>
let g:ycm_confirm_extra_conf = 0

" Easy motion short cut key
let g:EasyMotion_leader_key = ";"

" Set alternate search path
let g:alternateSearchPath = 'sfr:./'

" Auto save buff and keep the change history
set autowriteall
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

"Persistent undo
set undofile                " Save undo's after file closes
set undodir=$HOME/vim/undo  " where to save undo histories, make sure it's existed, or else create it manually
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" Hightlight current line
autocmd BufEnter * setlocal cursorline

set list listchars=tab:>-,trail:.,precedes:<,extends:>
autocmd BufWinLeave * call clearmatches()
"au BufWinEnter * let w:m1=matchadd('Search', '\%<81v.\%>77v', -1)
"au BufWinEnter * let w:m2=matchadd('Underlined', '\%>78v.\+', -1)

autocmd BufWritePre  *.{as,lua,cpp,h,c,py,js,etc}  call StripTrailingWhite()
autocmd BufWritePre  *.{as,lua,cpp,h,c,py,js,etc}  call StripTabs()
function! StripTrailingWhite()
    let l:winview = winsaveview()
    silent! %s/\s\+$//
    call winrestview(l:winview)
endfunction
function! StripTabs()
    let l:winview = winsaveview()
    silent! %s/\t/    /g
    call winrestview(l:winview)
endfunction

function ExplorerCurrentBuffer()
    exec ":silent !explorer /select, %:p"
endfunction
" Open the selected buffer in windows explorer
nmap <F10> :!start explorer /select, %:p<CR>
" For Mac
nmap <F10> :silent !open -R %:p<CR>

" Show dec or hex of current number-word under cursor
nnoremap gn :call DecAndHex(expand("<cWORD>"))<CR>
function! DecAndHex(number)
  let ns = '[.,;:''"<>()^_lL]'      " number separators
  if a:number =~? '^' . ns. '*[-+]\?\d\+' . ns . '*$'
     let dec = substitute(a:number, '[^0-9+-]*\([+-]\?\d\+\).*','\1','')
     echo dec . printf('  ->  0x%X, -(0x%X)', dec, -dec)
  elseif a:number =~? '^' . ns. '*\%\(h''\|0x\|#\)\?\(\x\+\)' . ns . '*$'
     let hex = substitute(a:number, '.\{-}\%\(h''\|0x\|#\)\?\(\x\+\).*','\1','')
     echon '0x' . hex . printf('  ->  %d', eval('0x'.hex))
     if strpart(hex, 0,1) =~? '[89a-f]' && strlen(hex) =~? '2\|4\|6'
        " for 8/16/24 bits numbers print the equivalent negative number
        echon ' ('. float2nr(eval('0x'. hex) - pow(2,4*strlen(hex))) . ')'
     endif
     echo
  else
     echo "NaN"
  endif
endfunction

" Highlight c operator
autocmd! BufRead,BufNewFile,BufEnter *.{c,cpp,h,javascript} call CSyntaxAfter()

" Fold marker
set fdm=marker

" Surround selection with character
"vnoremap ( <ESC>`>i)<ESC>`<i(<ESC>
"vnoremap " <ESC>`>i"<ESC>`<i"<ESC>
"vnoremap ' <ESC>`>i'<ESC>`<i'<ESC>
"vnoremap { <ESC>`>i}<ESC>`<i{<ESC>
"vnoremap [ <ESC>`>i]<ESC>`<i[<ESC>

" au BufRead,BufNewFile *.jar,*.war,*.ear,*.sar,*.rar set filetype=zip

" Grep under windows
set grepprg=findstr\ /n\ /s

command -nargs=+ FullMatchSearch :call g:FullMatchSearch(<f-args>)
command -nargs=+ PartialMatchSearch :call g:PartialMatchSearch(<f-args>)

function! g:FullMatchSearch(pattern, searchDir)
    exec "grep \"\\<" . a:pattern . "\\>\" " . a:searchDir
    cw
endfunction

function! g:PartialMatchSearch(pattern, searchDir)
    exec "grep \"" . a:pattern . "\" " . a:searchDir
    cw
endfunction

nmap <leader>f :FullMatchSearch <c-r>=expand("<cword>")<cr> 
nmap <leader>F :PartialMatchSearch <c-r>=expand("<cword>")<cr> 

" Set tail height
let g:tail#Height = 30

" actionscript language
let tlist_actionscript_settings = 'actionscript;c:class;f:method;p:property;v:variable'

" Treat long line as break lines
map j gj
map k gk

" Make cmdline tab completion similar to bash
set wildmode=list:longest
" Auto complete for command in status bar
set wildmenu
set wildmode=longest:full,full


" For comment useless param
nmap mc i/*<Esc>wea*/<Esc>k

" Use pylint
set makeprg=pylint\ --reports=n\ --rcfile=pylint.conf\ --output-format=parseable\ %:p
set errorformat=%f:%l:\ %m
nmap <leader>m :make<cr> 

" Format json
nmap <leader>j :%!python -m json.tool<cr>

" Open as maximum window
au GUIEnter * simalt ~x
" For Mac
" set lines=999 columns=999
