set shell=/bin/bash
runtime macros/matchit.vim

set ttyfast
set lazyredraw

let g:ruby_path="~/.rvm/bin/ruby"

" have jsx highlighting/indenting work in .js files as well
let g:jsx_ext_required = 0

let $PATH='/usr/local/bin:' . $PATH

:au FocusLost * :wa "Save on focus lost

" Sessions
let g:session_autoload = 'no'

" Leader Mappings
map <Space> <leader>
map <Leader>w :update<CR>
map <Leader>q :wq<CR>
map <Leader>Q :q<CR>
map <Leader>gs :Gstatus<CR>
map <Leader>gc :Gcommit<CR>
map <Leader>gp :Gpush<CR>


" Toggle nerdtree with F10
map <F10> :NERDTreeToggle<CR>
" Current file in nerdtree
map <F9> :NERDTreeFind<CR>
" Open nerdtree if I run vim on a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" Close vim if nerdtree is the only open window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Reduce timeout after <ESC> is recieved.
set ttimeout
set ttimeoutlen=20
set notimeout

" highlight vertical column of cursor
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline
set cursorline

" Leave paste mode on exit
au InsertLeave * set nopaste

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=500
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set noerrorbells  " No beeps

" Search
set incsearch     " do incremental searching
set hlsearch      " highlight matches
set ignorecase    " Case insensitive search
set smartcase     " ...unless search contains uppercase letter

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'christoomey/vim-tmux-navigator'
call vundle#end()

" Pathogen
execute pathogen#infect()


" Fuzzy finder: ignore stuff that can't be opened, and generated files
let g:fuzzy_ignore = "*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;vendor/**;coverage/**;tmp/**;rdoc/**"

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" Softtabs, 2 spaces
set smarttab      " better tabs
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent    " Copy indentation from prev line
set shiftround    " always indent by multiple of shiftwidth
filetype plugin indent on

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-/> :TmuxNavigatePrevious<cr>
" Scroll
set scrolloff=5       " keep at least 5 lines above/below

" Treat given characters as a word bondary
set iskeyword-=.
set iskeyword-=#

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Airline
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
set t_Co=256

:set smartcase
:set ignorecase

" Color scheme
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark " or light
colorscheme gruvbox


" Numbers
set number
set numberwidth=5
set relativenumber

" Persistent undo
set undodir=~/.vim/undo
set undofile
set undolevels=1000
set undoreload=10000

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
set complete=.,w,t
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement. Seemlessly navigate between Vim/Tmux panes
let g:tmux_navigator_no_mappings = 1

" Remap control navigate to navigate windows
nnoremap <C-T> :NERDTreeToggle<CR>

" Quick sourcing of the current file, allowing for quick vimrc testing
nnoremap <leader>sop :source %<cr>

" Plugins via Plug
call plug#begin('~/.vim/plugged')
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  let g:deoplete#enable_at_startup = 1
endif
Plug 'StanAngeloff/php.vim'
call plug#end()

function! s:Open(file)
  exec('vsplit ' . a:file)
endfunction
" Write all buffers before navigating from Vim to tmux pane
let g:tmux_navigator_save_on_switch = 2

" ~~~~ Emmet ~~~~
" let g:user_emmet_mode='n'    "only enable normal mode functions.

"~~~~ FORMATTING ~~~~
"
" Auto run prettier on all applicable files by default
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html,*.blade.php Prettier

" Try to fix prettier config precedence settings
let g:prettier#config#config_precedence = 'file-override'
" max line length that prettier will wrap on
" Prettier default: 80
let g:prettier#config#print_width = 80

" number of spaces per indentation level
" Prettier default: 2
let g:prettier#config#tab_width = 2

" use tabs over spaces
" Prettier default: false
let g:prettier#config#use_tabs = 'false'

" print semicolons
" Prettier default: true
let g:prettier#config#semi = 'true'

" single quotes over double quotes
" Prettier default: false
let g:prettier#config#single_quote = 'true'

" print spaces between brackets
" Prettier default: true
let g:prettier#config#bracket_spacing = 'false'

" put > on the last line instead of new line
" Prettier default: false
let g:prettier#config#jsx_bracket_same_line = 'true'

" avoid|always
" Prettier default: avoid
let g:prettier#config#arrow_parens = 'always'

" none|es5|all
" Prettier default: none
let g:prettier#config#trailing_comma = 'all'

" flow|babylon|typescript|css|less|scss|json|graphql|markdown
" Prettier default: babylon
let g:prettier#config#parser = 'flow'

" cli-override|file-override|prefer-file
let g:prettier#config#config_precedence = 'prefer-file'

" always|never|preserve
let g:prettier#config#prose_wrap = 'preserve'

" css|strict|ignore
let g:prettier#config#html_whitespace_sensitivity = 'css'

" Auto format php files
"autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()
" and add some mappings for it too
nnoremap <silent><leader>pcd :call PhpCsFixerFixDirectory()<CR>
nnoremap <silent><leader>pcf :call PhpCsFixerFixFile()<CR>

