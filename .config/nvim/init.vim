"thogen#infect()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
 call plug#begin('~/.local/share/nvim/site/autoload/')

 " Make sure you use single quotes

 " Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
 Plug 'junegunn/vim-easy-align'

 " Any valid git URL is allowed
 Plug 'https://github.com/junegunn/vim-github-dashboard.git'

 " Multiple Plug commands can be written in a single line using | separators
 "Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

 " On-demand loading
 Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
 Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

 " Using a non-master branch
 Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

 " Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
 Plug 'fatih/vim-go', { 'tag': '*' }

 " Plugin options
 Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

 " Plugin outside ~/.vim/plugged with post-update hook
 Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

 " Unmanaged plugin (manually installed and updated)
 Plug '~/my-prototype-plugin'

 Plug 'lervag/vimtex'
 Plug 'jalvesaq/Nvim-R'
 Plug 'vim-latex/vim-latex'
 Plug 'jalvesaq/colorout'
 Plug 'scrooloose/nerdtree'
 "Plug 'ensime/ensime-vim'
 Plug 'vim-syntastic/syntastic'
 Plug 'derekwyatt/vim-scala'
 Plug 'powerline/powerline'
" Plug 'ctrlp.vim'
 Plug 'vim-scripts/Conque-Shell'
 Plug 'jnurmine/Zenburn'
 Plug 'altercation/vim-colors-solarized'
 Plug 'Lokaltog/powerline'
 Plug 'daeyun/vim-matlab'
 Plug 'davidhalter/jedi-vim'
 Plug 'ivanov/vim-ipython'
 Plug 'jceb/vim-orgmode'
 Plug 'tpope/vim-speeddating'
 Plug 'itchyny/lightline.vim'
 Plug 'benmills/vimux'
 Plug 'flycheck/flycheck'
 " Initialize plugin system

 """"""""""""""""""""""""Color Schemes"""""""""""""""""""""""""""""""""""""""""""
 Plug 'flazz/vim-colorschemes'
 Plug 'reewr/vim-monokai-phoenix'
 call plug#end()

 """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



 "":highlight Normal ctermfg=blue ctermbg=gray


 " Don't try to be vi compatible
 set nocompatible

 " Helps force plugins to load correctly when it is turned back on below
 filetype off

 " TODO: Load plugins here (pathogen or vundle)

 " Turn on syntax highlighting
 syntax on

 " For plugins to load correctly
 filetype plugin indent on

 " TODO: Pick a leader key
 " let mapleader = ","

 " Security
 set modelines=0
 " Show line numbers
 set number

 " Show file stats
 set ruler

 " Blink cursor on error instead of beeping (grr)
 set visualbell

 " Encoding
 set encoding=utf-8

 " Whitespace
 set wrap
 set textwidth=79
 set formatoptions=tcqrn1
 set tabstop=2
 set shiftwidth=2
 set softtabstop=2
 set expandtab
 set noshiftround

 " Cursor motion
 set scrolloff=3
 set backspace=indent,eol,start
 set matchpairs+=<:> " use % to jump between pairs
 runtime! macros/matchit.vim

 " Move up/down editor lines
 nnoremap j gj
 nnoremap k gk

 " Allow hidden buffers
 set hidden

 " Rendering
 set ttyfast

 " Status bar
 set laststatus=2

 " Last line
 set showmode
 set showcmd

 " Searching
 nnoremap / /\v
 vnoremap / /\v
 set hlsearch
 set incsearch
 set ignorecase
 set smartcase
 set showmatch
 map <leader><space> :let @/=''<cr> " clear search

 " Remap help key.
 inoremap <F1> <ESC>:set invfullscreen<CR>a
 nnoremap <F1> :set invfullscreen<CR>
 vnoremap <F1> :set invfullscreen<CR>

 " Textmate holdouts

 " Formatting
 map <leader>q gqip

 " Visualize tabs and newlines
 set listchars=tab:▸\ ,eol:¬
 " Uncomment this to enable by default:
 " set list " To enable by default
 " Or use your leader key + l to toggle on/off
 map <leader>l :set list!<CR> " Toggle tabs and EOL

 " Color scheme (terminal)
 set t_Co=256
 set background=dark
 let g:solarized_termcolors=256
 let g:solarized_termtrans=1



 """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 set guifont=Monospace\ 11

 syntax enable
 set background=dark
 colorscheme vividchalk
 
 if has('gui_running')
     set background=light
     else
         set background=dark
         endif

         "Not showing undeline
         :hi CursorLine cterm=none
         :hi CursorLine gui=none

         set cursorline
         highlight CursorLine guifg=white guibg=blue  ctermbg=234 cterm=bold
         autocmd InsertEnter * highlight CursorLine guifg=white guibg=grey  ctermbg=235 cterm=bold
         autocmd InsertLeave * highlight CursorLine guifg=white guibg=blue  ctermbg=234 cterm=bold
	 "autocmd InsertLeave * highlight CursorLine guifg=white guibg=green ctermfg=white ctermbg=25 cterm=bold
         "set cursorcolumn



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:EclimCompletionMethod = 'omnifunc'
let g:ycm_python_binary_path = '/usr/bin/python'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
ino ;; <esc>
set nobackup
""""""""""""""""""""""""""""Spell Check"""""""""""""""""""""""""""""""""""""""""
"set spell
"set spelllang=en
"autocmd BufRead,BufNewFile *.md setlocal spell
"autocmd BufRead,BufNewFile *.txt setlocal spell
"set complete+=kspell

"let vimrplugin_underscore = 0

""""""""""""""""""""""""""""""""""Nvim-R"""""""""""""""""""""""""""""""""""""""""
"Change assihnment operator ->
let R_assign_map = "r|"



""""""""""""""""""""""" Copy to Clipboard '"""""""""""""""""""""""""""""""""""""
set clipboard=unnamedplus
vnoremap <C-c> "+y
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_enable_r_lintr_checker = 1
let g:syntastic_r_checkers = ['lintr']

set guioptions=r
