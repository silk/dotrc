set nocompatible

set modelines=2
set backspace=indent,eol,start

"set mouse=a

set confirm
set autoindent
set smartindent
set nobackup                    " do not keep a backup file, use versions instead
set history=100                  " keep 50 lines of command line history
set ruler
set showcmd
set incsearch
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set scrolloff=3
set listchars=tab:>-,trail:x
set list
" set showbreak=>>
set nowrap
set number
set showmatch
set foldenable
set splitbelow
set splitright
set previewheight=6
set title
set hidden

set lazyredraw
set laststatus=2

"set formatoptions-=l
set shortmess+=I

"set rulerformat=%l,%c%V%=#%n\ %3p%%         " Content of the ruler string
set ignorecase smartcase

syntax on
set hlsearch
colorscheme koehler

filetype plugin indent on
autocmd FileType text setlocal textwidth=78

" jump to last position in file
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

" laduje plugin Man - "K" uruchamia man dla wyrazu pod kursorem
" source $VIMRUNTIME/ftplugin/man.vim

" ***************
"  Abbreviations
" ***************
"  Some C abbreviations
iab  Zmain  int main(int argc, char *argv[])<CR>{<CR>}<Up>
iab  Zinc  #include
iab  Zdef  #define
"  Some other abbreviations
iab  Zdate  <C-R>=strftime("%Y-%m-%d")<CR>
iab  Ztime  <C-R>=strftime("%H:%M:%S")<CR>
iab  Zmail silk@boktor.net
iab  Zfilename <C-R>=expand("%:t:r")<CR>
iab  Zfilepath <C-R>=expand("%:p")<CR>
"  C#
iab  /// /// <summary><enter><c-u>///<enter><c-u>/// </summary><up>

" ***************
"  Skroty
" ***************

let mapleader = ","

" F2 wlacza i wylacza zawijanie wierszy
nmap <F2> :set wrap!<CR>
imap <F2> <ESC>:set wrap!<CR>
" F3 wylacza podswietlenie ostatnio szukanego tekstu
nmap <F3> :nohlsearch<CR>
imap <F3> <ESC>:nohlsearch<CR>
nmap <F5> :cnext<CR>
imap <F5> <ESC>:cnext<CR>
nmap <F6> :cprevious<CR>
imap <F6> <ESC>:cprevious<CR>
nmap <F7> :clist<CR>
imap <F7> <ESC>:clist<CR>
" F8 uruchamia make w aktualnym katalogu
:command -nargs=* Make make <args> | cwindow 3
map <F8> :w<CR>:Make<CR>

nmap <F10> :!!<CR>
imap <F10> <ESC>:!!<CR>
nmap <F11> :call SwitchTabstop()<CR>
imap <F11> <ESC>:call SwitchTabstop()<CR>i
nmap <F12> :call SwitchExpandtab()<CR>
imap <F12> <ESC>:call SwitchExpandtab()<CR>i

"  Show next buffer
nmap <TAB> :bnext<CR>
"  Align line
nmap ,ac :center<CR>
nmap ,al :left<CR>
nmap ,ar :right<CR>

"  Print the ASCII value of the character under the cursor
nmap ,as :ascii<CR>
"  Change type of <EOL> - unix/dos
nmap ,eol :call ChangeFileFormat()<CR>
"  Remove all empty lines
nmap ,re :g/^$/d<CR>
"  Edit .vimrc
nmap ,rc :n $HOME/.vimrc<CR>

" TagList mappings
nnoremap <silent> <F4> :TlistToggle<CR>
let Tlist_Auto_Open = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Exit_OnlyWindow = 1
let Tlist_Display_Tag_Scope = 0 " for C# it's useless, maybe set it accordingly to ft?
let Tlist_Process_File_Always = 1
let Tlist_Use_Right_Window = 1
let Tlist_WinWidth = 40

" let Tlist_Inc_Winwidth = 0  " set to 0 if you have strange problems with screen resizing

"" dobry pomysl - ale nie dziala do poprawki
"" Make ',e' (in normal mode) give a prompt for opening files
"" in the same dir as the current buffer's file.
""if has("unix")
""  map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
""else
""  map ,e :e <C-R>=expand("%:p:h") . "\\" <CR>
""endif
"
" set modifiable state of buffer to match readonly state (unless overridden manually)
function UpdateModifiable() 
    if &readonly 
        setlocal nomodifiable 
    else 
        setlocal modifiable 
    endif 
endfunction

autocmd BufReadPost * call UpdateModifiable()

"" ***************
""  Funkcje
"" ***************
"
function ChangeFileFormat()
 if &fileformat == "unix"
  set fileformat=dos
  echo "<EOL> type: DOS"
 else
  set fileformat=unix
  echo "<EOL> type: UNIX"
 endif
endfunction

function SwitchTabstop()
 if &tabstop == 4
  set tabstop=2
  set shiftwidth=2                " dlugosc wciec
  set softtabstop=2               " BS traktuje 4 spacje jak tab
  echo "Tabstop = 2"
 else
  set tabstop=4
  set shiftwidth=4                " dlugosc wciec
  set softtabstop=4               " BS traktuje 4 spacje jak tab
  echo "Tabstop = 4"
 endif
endfunction

function SwitchExpandtab()
 if &expandtab == 1
  set noexpandtab
  echo "Expandtab OFF"
 else
  set expandtab
  echo "Expandtab ON"
 endif
endfunction

" auto H headers guarding in new files

function! s:insert_gates()
    let gatename = "__" . substitute(toupper(expand("%:t")), "\\.", "_", "g") . "__"
    execute "normal i#ifndef " . gatename
    execute "normal o#define " . gatename . "   "
    execute "normal 2o"
    execute "normal Go#endif /* " . gatename . " */"
    normal kk
endfunction

if has("autocmd")
  autocmd BufNewFile *.{h,hpp} call <SID>insert_gates() 

  " overwrite Puppet module
  autocmd FileType puppet setlocal shiftwidth=4 tabstop=4 softtabstop=4

  " drupal modules
  augroup module
    autocmd BufNewFile,BufRead *.module set filetype=php
    autocmd BufNewFile,BufRead *.install set filetype=php
  augroup END
endif

let php_sql_query = 1
let php_baselib = 1
let php_htmlInStrings = 1

