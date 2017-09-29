"###############################################################################
" Vundle
"###############################################################################
" http://erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme) 
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

Plugin 'Mizuchi/vim-ranger'
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'rust-lang/rust.vim'
Plugin 'scrooloose/syntastic'
Plugin 'sjl/gundo.vim'
Plugin 'terryma/vim-smooth-scroll'
Plugin 'jplaut/vim-arduino-ino'
Plugin 'dahu/vim-help' " i want to navigate like vim-FX, zathura
Plugin 'lervag/vimtex'
" Plugin 'tpope/vim-fugitive' "So awesome, it should be illegal
" Plugin 'kien/ctrlp.vim'

if iCanHazVundle == 0
    echo "Installing Vundles, please ignore key map error messages"
    echo ""
    :PluginInstall
endif
call vundle#end() "must be last

"###############################################################################
" Basic Setup
"###############################################################################
set ruler		" show the cursor position all the time
set showcmd		     " display incomplete commands
set wildmenu		 " display completion matches in a status line
set ttimeout		 " time out for key codes
set ttimeoutlen=100	 " wait up to 100ms after Esc for special key
set display=truncate " Show @@@ in the last line if it is truncated.
set showmatch        " highlight matching [{()}]
set history=200	     " keep 50 lines of command line history
set incsearch	     " do incremental searching
set hlsearch         " highlighting last search
set cursorline
set number           " Absolute Zeilenzahl
set scrolloff=8      " keep cursor away from border
set nowrap
set colorcolumn=81   " highlight column 81
set nrformats-=octal " Don't recognize octal numbers for C-A & C-X, it's confusing.
set clipboard=unnamedplus " Systemclipboard / Register
set backspace=indent,eol,start " allow backspacing over everything in insert mode
if has('mouse') | set mouse=a | endif " enable mouse
" tabulator
set tabstop=4        " The width of a TAB is set to 4.
set shiftwidth=4
set softtabstop=4    " Sets the number of columns for a TAB
set expandtab        " Expand TABs to spaces
" folds
set foldcolumn=1
setlocal foldmethod=indent " marker, manual, expr, syntax, diff
set foldenable
set foldlevelstart=10 " open most folds by default
set foldnestmax=10    " 10 nested fold max
" backup, swap and undos storage
set directory=~/.vim/dirs/tmp     " directory to place swap files in
set backup                        " make backup files
set backupdir=~/.vim/dirs/backups " where to put backup files
set undofile                      " persistent undos - undo after re-opening a file
set undodir=~/.vim/dirs/undos
set viminfo+=n~/.vim/dirs/viminfo
let g:yankring_history_dir = '~/.vim/dirs/' " store yankring history file there
" create needed directories if they don't exist
if !isdirectory(&backupdir) | call mkdir(&backupdir, "p") | endif
if !isdirectory(&directory) | call mkdir(&directory, "p") | endif
if !isdirectory(&undodir)   | call mkdir(&undodir, "p")   | endif

" Statusline
set laststatus=1 " 0 never, 1 if tiled, 2 always
set statusline=%<%f\     " Filename
set statusline+=%w%h%m%r " Options
set statusline+=\ [%{getcwd()}] " current dir
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on
    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
    au!
    autocmd VimResized * wincmd = " adapt tiling ratios on resize
    autocmd! bufwritepost .vimrc source % " Automatic reloading of .vimrc
    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
        \ if line("'\"") >= 1 && line("'\"") <= line("$") |
        \     exe "normal! g`\"" |
        \ endif
    augroup END
else
    set autoindent		" always set autoindenting on
endif " has("autocmd")

colorscheme solarized
" make changes in the scheme, as they would be lost afer saving
" autocmd ColorScheme * highlight WildMenu ctermfg=8 ctermbg=6
set background=dark " dark | light "
let g:solarized_contrast="high"

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
    " Prevent that the langmap option applies to characters that result from a
    " mapping.  If unset (default), this may break plugins (but it's backward
    " compatible).
    set langnoremap
endif

"###############################################################################
" Language Specific
"###############################################################################
syntax enable             " enable syntax
filetype plugin indent on " load filetype plugins/indent settings
set wildignore+=*.pyc,*_build/*,*/coverage/* " ignorierte Dateiendungen
let c_comment_strings=1 " highlighting strings inside C comments.

" python specific
au BufNewFile,BufRead *.py map <Leader>b Oimport pdb; pdb.set_trace()<C-c>
au BufNewFile,BufRead *.py cabbrev run !python %:p

" yml specific
au BufNewFile,BufRead,BufEnter *.yml syntax off " enable syntax

" c specific (and patches)
au BufNewFile,BufRead,BufEnter *.c,*.h,*.diff setlocal noexpandtab " 
au FileType make setlocal noexpandtab

"###############################################################################
" mapping
"###############################################################################
let mapleader = ","
" quicker commands
map ö :
" register choice
map ü "
" go to marking
map ä '
" space open/closes folds
nnoremap <space> za
" dont put single charcters in clipboard
nnoremap x "_x

cabbrev vh vert bo help

" easier moving of code blocks
" go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv
vnoremap > >gv

" CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Navigation
" movement
map <Esc>w 3w
map <Esc>e 3e
map <Esc>b 3b
" tab navigation mappings
map <silent> tn :tabnext<CR>
map <silent> tp :tabprevious<CR>
map <silent> ts :tab split<CR>
map tm :tabmove
map tt :tabnew 
" alt-1 for tab 1
nnoremap <Esc>1  1gt
nnoremap <Esc>2  2gt
nnoremap <Esc>3  3gt
nnoremap <Esc>4  4gt
nnoremap <Esc>5  5gt
nnoremap <Esc>6  6gt
nnoremap <Esc>7  7gt
nnoremap <Esc>8  8gt
nnoremap <Esc>9  9gt
nnoremap <Esc>0 10gt

" tile navigation mappings
" Ctrl makes trouble with shift, now use alt
let g:C_Ctrl_j = 'off'
map <C-h> <C-w>H
map <C-j> <C-w>J
map <C-k> <C-w>K
map <C-l> <C-w>L

" http://stackoverflow.com/questions/7501092/can-i-map-alt-key-in-vim
" in st cat > Alt+h returns ^[h ... so ESC h
" alt workaround:
nnoremap <Esc>h <C-w>h
nnoremap <Esc>j <C-w>j
nnoremap <Esc>k <C-w>k
nnoremap <Esc>l <C-w>l
nnoremap <Esc>H 3<C-w><
nnoremap <Esc>J 3<C-W>-
nnoremap <Esc>K 3<C-W>+
nnoremap <Esc>L 3<C-w>>

" toggled options
nnoremap <silent> <leader>h :call SearchToggle()<cr>
nnoremap <silent> <leader>n :call NumberToggle()<cr>
nnoremap <silent> <leader>w :call WrapToggle()<cr>
nnoremap <silent>         B :call BarToggle()<CR>
nnoremap <silent> <leader>u :GundoToggle<CR>
nnoremap          <leader>s :SyntasticToggleMode<CR>

function! BarToggle()
    if(&ls == 1)  | set laststatus=2
    else          | set laststatus=1  | endif
endfunction
function! SearchToggle()
    if(&hls == 1)  | set nohlsearch
    else           | set hlsearch  | endif
endfunction
function! WrapToggle()
    if(&wrap == 1) | set nowrap
    else           | set wrap      | endif
endfunction
function! NumberToggle()
    if(&rnu == 1)  | set norelativenumber | set number
    else           | set relativenumber   | endif
endfunction

" show duplicaded lines
function! HighlightRepeats() range
    let lineCounts = {}
    let lineNum = a:firstline
    while lineNum <= a:lastline
        let lineText = getline(lineNum)
        if lineText != ""
            let lineCounts[lineText] = (has_key(lineCounts, lineText) ? lineCounts[lineText] : 0) + 1
        endif
        let lineNum = lineNum + 1
    endwhile
    exe 'syn clear Repeat'
    for lineText in keys(lineCounts)
        if lineCounts[lineText] >= 2
            exe 'syn match Repeat "^' . escape(lineText, '".\^$*[]') . '$"'
        endif
    endfor
endfunction
command! -range=% HighlightRepeats <line1>,<line2>call HighlightRepeats()

"###############################################################################
" Pluginsetup
"###############################################################################
" SmoothScroll
function! SmoothScrolll()
    nnoremap <silent> <C-u> :call smooth_scroll#up(&scroll,     10, 4)<CR>
    nnoremap <silent> <C-d> :call smooth_scroll#down(&scroll,   10, 4)<CR>
    nnoremap <silent> <C-b> :call smooth_scroll#up(&scroll*2,   10, 4)<CR>
    nnoremap <silent> <C-f> :call smooth_scroll#down(&scroll*2, 10, 4)<CR>
endfunction
call SmoothScrolll()

function! NoSmoothScroll()
    unmap <C-u>
    unmap <C-d>
    unmap <C-b>
    unmap <C-f>
endfunction

" ctrlp
" let g:ctrlp_max_height = 30

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs=1

" let g:syntastic_python_python_exec = '/usr/bin/python2'

" for gundo, syntastic leadermappings see mappings

"###############################################################################
" Trash, tried but failed. But dont dispose yet
"###############################################################################
" desired, but too slow. While scolling, cursor jumps badly.
    " mark overlength
    " autocmd BufEnter * highlight OverLength ctermbg=0 guibg=#592929
    " autocmd BufEnter * match OverLength /\%81v.*/
    
    " Show whitespace, MUST be inserted BEFORE the colorscheme command
    " autocmd ColorScheme * highlight ExtraWhitespace ctermbg=blue guibg=blue
    " au InsertLeave * match ExtraWhitespace /\s\+$/

" no need
  " map Q gq " Don't use Ex mode, use Q for formatting | never used yet
  " nnoremap          <leader>w :mksession<CR> " vim -S


" Omnicomplete
"function! CleverTab()
"if pumvisible()
"    return "\<C-N>"
"endif
"if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
"    return "\<Tab>"
"elseif exists('&omnifunc') && &omnifunc != ''
"    return "\<C-X>\<C-O>"
"else
"    return "\<C-N>"
"endif
"endfunction
"inoremap <Tab> <C-R>=CleverTab()<CR>
"" close omni-complete help when typing is done
"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"###############################################################################
" Playground, test here and insert cleanly later above
"###############################################################################

" Menu
" source $VIMRUNTIME/menu.vim
" set wildmenu
" set cpo-=<
" set wcm=<C-Z>
" map <F4> :emenu <C-Z>

