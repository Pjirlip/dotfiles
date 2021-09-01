set nocompatible
source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/lua/setup.lua

set termguicolors
"colorscheme doom-one
"colorscheme monokai

let mapleader=","
let g:nvim_tree_auto_open = 1
let g:nvim_tree_auto_close = 1
let g:nvim_tree_follow = 1
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_git_hl = 1
let g:nvim_tree_group_empty = 1
let g:nvim_tree_add_trailing = 1
let g:tokyonight_style = "storm"
let g:tokyonight_sidebars = [ "qf", "vista_kind", "terminal", "packer", "NvimTree"]
let g:tokyonight_terminal_colors = 1
let g:tokyonight_transparent_sidebar = 1
let g:suda_smart_edit = 1 " Auto Sudo if no r/w permission
let g:dashboard_default_executive = "telescope"
let g:doom_one_terminal_colors = v:true
let g:doom_one_cursor_coloring = v:true
let g:ranger_map_keys = 0

colorscheme tokyonight

set hidden
set number
set relativenumber
set timeoutlen=300
set hlsearch
set smartcase
set ignorecase
set incsearch
set autoindent
set shiftwidth=4
set smartindent
set smarttab
set softtabstop=4
set noshowmode
set mouse=a
set tabstop=4 shiftwidth=4 expandtab
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable
set whichwrap+=<,>,h,l,[,] "GO to next/prev Line on End/Start of Line
set iskeyword+=-
set signcolumn=yes
syntax enable

set cursorline
hi CursorLineNr   term=bold ctermfg=Yellow gui=bold guifg=Yellow

" file type recognition
filetype on
filetype plugin on
filetype indent on

" Setup NerdTree
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
nnoremap <silent><Space> :NvimTreeFocus<CR>

" Auto start NERD tree when opening a directory
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NvimTreeToggle' argv()[0] | wincmd p | ene | wincmd p | endif

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" LSP Additons Setup
nnoremap <silent><leader>h <cmd> :Lspsaga lsp_finder<CR>
nnoremap <silent><leader>a <cmd> :Lspsaga code_action<CR>
nnoremap <silent><leader>d <cmd> :Lspsaga hover_doc<CR>
nnoremap <silent><leader>lr <cmd> :Lspsaga rename<CR>
nnoremap <silent><leader>ls <cmd> :Lspsaga signature_help<CR>
nnoremap <silent> K <cmd> :Lspsaga hover_doc<CR>
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

" Use completion-nvim in every buffer
set completeopt=menuone,noselect

" toggle line numbers
nnoremap <silent> <leader>n :set number! relativenumber!<CR>

" use ,, for escape
inoremap ,, <Esc>


let g:material_theme_style = 'darker'

nnoremap <silent><leader>g <cmd> :LazyGit<CR>
nnoremap <silent><leader>t <cmd> :ToggleTerm<CR>

" Jump to Buffers
nnoremap <leader>m :ls<cr>:b<space>

"NavBar Mapping for next/prev
nnoremap <silent><M-left>   <CMD> :BufferLineCyclePrev<CR>
nnoremap <silent><M-right>  <CMD> :BufferLineCycleNext<CR>
nnoremap <silent><M-up>     <CMD> :Bwipeout<CR>
inoremap <silent><M-left>   <CMD> :BufferLineCyclePrev<CR>
inoremap <silent><M-right>  <CMD> :BufferLineCycleNext<CR>
inoremap <silent><M-up>     <CMD> :Bwipeout<CR>

" AutoCompletion Mappings
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" Disable accidental Cursor Position on WIndows Focus
augroup NO_CURSOR_MOVE_ON_FOCUS
  au!
  au FocusLost * let g:oldmouse=&mouse | set mouse=
  au FocusGained * if exists('g:oldmouse') | let &mouse=g:oldmouse | unlet g:oldmouse | endif
augroup END

" Snippet Config
" NOTE: You can use other key to expand snippet.

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

nnoremap <silent><leader>q <CMD> :q!<CR>
nnoremap <silent><leader>w <CMD> :w!<CR>
nnoremap <silent><leader>x <CMD> :wq!<CR>

" EsLint Setup 

let g:ale_linters = {
\   'javascript': ['eslint']
\}

let g:ale_fixers = ['eslint']

let g:ale_sign_error = '🅧'
let g:ale_sign_warning = '⚠'

let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_use_local_config = 1

autocmd BufWritePost *.js,*.jsx,*.py,*.vue ALEFix

" Folding
nnoremap <silent><Tab> za <CR>

" Train Tracks =)
nnoremap <silent><leader>k <CMD> :call train#show_matches(['w', 'j', 'b', 'e', '^', 'H', 'M', 'L', ']', '[', ']]', '{', '}', '[['])<CR>

" Setup Scrollbar
augroup ScrollbarInit
  autocmd!
  autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
  autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()
  autocmd WinLeave,BufLeave,BufWinLeave,FocusLost            * silent! lua require('scrollbar').clear()
augroup end

" Set Key Modifier for Twiligh Toggle
nnoremap <silent><leader>t <CMD> :Twilight <CR> 

" Quickkeys for Opening this config File and Plugins VIM
nnoremap <silent><leader>vc <cmd> :e $MYVIMRC <CR>
nnoremap <silent><leader>vr <cmd> :source $MYVIMRC <CR> 
nnoremap <silent><leader>vp <cmd> :e $HOME/.config/nvim/vim-plug/plugins.vim <CR>


" Ranger integration
noremap <silent><leader>r <cmd> :Ranger <CR>

" Add Yank support to iterm2 Terminal in visual Mode 
vnoremap <leader>c :OSCYank<CR>


