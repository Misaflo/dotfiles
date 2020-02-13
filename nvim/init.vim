"====================
" Plugins (vim-plug)
"====================

call plug#begin()

Plug 'junegunn/fzf'
Plug 'dense-analysis/ale'
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' } " require exuberant-ctags or universal-ctags
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'terryma/vim-multiple-cursors'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'junegunn/vim-easy-align'
Plug 'othree/html5.vim'
Plug 'ap/vim-css-color'
Plug 'pangloss/vim-javascript'
Plug '1995eaton/vim-better-javascript-completion'
Plug 'vim-ruby/vim-ruby'
Plug 'noprompt/vim-yardoc'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'gruvbox-community/gruvbox'
Plug 'previm/previm'
Plug 'dpelle/vim-Grammalecte'
Plug 'rodjek/vim-puppet'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-surround'
Plug 'nishigori/increment-activator'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'cespare/vim-toml'

call plug#end()

"====================
" General
"====================

let mapleader=","
set background=dark
let g:gruvbox_italic=1
colorscheme gruvbox

set number
set encoding=utf-8
set fileencoding=utf-8
set nofoldenable      " Disable folding
set splitbelow        " Split at the bottom
set splitright        " Vsplit at the right

set showmatch         " When a bracket is inserted, briefly jump to the matching one
set laststatus=2      " Always display the status line
set showcmd           " Show (partial) command in the last line of the screen
set wildmenu          " Command-line completion enhanced
set scrolloff=2       " Minimal number of screen lines to keep above and below the cursor
set cursorline        " Highlight the screen line of the cursor
set mouse=n           " Enable Mouse en normal mode.

set hlsearch          " When there is a previous search pattern, highlight all its matches
set ignorecase        " Ignoring case in a pattern
set incsearch         " While typing a search command, show where the pattern, as it was typed so far, matches

set smartindent       " Do smart autoindenting when starting a new line
set tabstop=2         " Number of spaces that a <Tab> in the file counts for
set shiftwidth=2      " Alignment with '<' and '>'
set expandtab         " Use spaces instead of tab

" Highlighted off
nmap <silent> <leader><space> :noh<CR>

hi SpellBad gui=none guifg=#ebdbb2 guibg=#cc241d
hi SpellCap gui=none guifg=#ebdbb2 guibg=#458588

if &diff
  set cursorline!
endif

" Show special characters
" Insert a non-breaking space: <C-k> <space> <space>
set list
set listchars=tab:>\ ,trail:\ ,nbsp:+
highlight NoSpacesEOL ctermbg=red ctermfg=white guibg=#592929
match NoSpacesEOL / \+$/

" 24-bit color
if has("termguicolors")
  set termguicolors
endif

" :W sudo saves the file
command W w !sudo tee % > /dev/null

" Search email in LDAP
function LDAPLookup()
  let @a = system('ldap_search_email '.expand('<cword>'))
endfunction
map <Leader>ls :call LDAPLookup() <CR>:s/<C-R><C-W>/<C-R>a<BACKSPACE>/g<CR>:noh<CR>$

" Live substitution
set inccommand=nosplit

"====================
" Terminal
"====================

" Map <Esc> to exit terminal-mode
tnoremap <Esc> <C-\><C-n>
" Open a terminal at the bottom
map <Leader>t :belowright split +terminal<CR>:resize -4<CR>i
" Disable line number in terminal-mode
autocmd TermOpen * setlocal nonumber norelativenumber

"====================
" Buffer
"====================

" https://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/
" This allows buffers to be hidden if you've modified a buffer
set hidden
" Move to the next buffer
nmap <leader>n :bnext!<CR>
" Move to the previous buffer
nmap <leader>p :bprevious!<CR>
" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>q :bp <BAR> bd #<CR>

"====================
" Syntax
"====================

autocmd BufEnter todo set syntax=todo

"====================
" Mail
"====================

autocmd FileType mail set spell spelllang=fr syntax=mailrt

"====================
" PHP
"====================

let php_sql_query=1       " SQL syntax highlighting inside Strings
let php_htmlInStrings=1   " Enable HTML syntax highlighting inside strings

"====================
" Ruby
"====================

" see :help ft-ruby-omni

"autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
"autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1 " This may cause some code execution
"autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
"autocmd FileType ruby,eruby let g:rubycomplete_include_object = 1
"autocmd FileType ruby,eruby let g:rubycomplete_include_objectspace = 1
let ruby_spellcheck_strings = 1

"====================
" Completion
"====================

" For completion of words (ctrl + x ctrl + k)
set dictionary+=/usr/share/dict/words

"====================
" Spellchecking
"====================

" Vim spell checker (z=)
if has("spell")
  map <leader>lf :set spell spelllang=fr<cr>
  map <leader>le :set spell spelllang=en<cr>
  map <leader>ln :set nospell<cr>
endif

set spellsuggest=5

"====================
" Plugins configuration
"====================

" fzf
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
noremap <silent> <leader>f :FZF<CR>

" ale
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" vim-yardoc
hi link yardGenericTag  rubyInstanceVariable
hi link yardType        Type
hi link yardLiteral     Type

" vim-airline
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline_symbols_ascii = 1

" vim-signify
let g:signify_vcs_list = [ 'git' ]

" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" tagbar
nmap <F8> :TagbarToggle<CR>

" vim-javascript
let g:javascript_plugin_jsdoc = 1 " Enables syntax highlighting for JSDocs

" easy-align
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" nerdcommenter
nnoremap <leader>c :call NERDComment(0,"toggle")<CR>
vnoremap <leader>c :call NERDComment(0,"toggle")<CR>

" nerdtree
nmap <F9> :NERDTreeToggle<CR>
" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" previm (markdown preview)
let g:previm_open_cmd = 'xdg-open'

" vim-Grammalecte
let g:grammalecte_cli_py='~/.dotfiles/nvim/grammalecte/grammalecte-cli.py'
hi GrammalecteGrammarError  gui=none guifg=#ebdbb2 guibg=#cc241d
hi GrammalecteSpellingError gui=none guifg=#ebdbb2 guibg=#458588
noremap <silent> <leader>gc :GrammalecteCheck<CR>
noremap <silent> <leader>gl :GrammalecteClear<CR>

" increment-activator
let g:increment_activator_filetype_candidates = {
  \   'puppet': [
  \     ['present', 'absent'],
  \   ],
  \ }
