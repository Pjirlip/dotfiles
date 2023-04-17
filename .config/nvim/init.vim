set nocompatible
source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/lua/setup.lua

set termguicolors

let mapleader=","
let g:tokyonight_style = "night"
let g:tokyonight_sidebars = [ "qf", "vista_kind", "terminal", "packer", "NvimTree"]
let g:tokyonight_terminal_colors = 1
let g:tokyonight_transparent_sidebar = 1
let g:suda_smart_edit = 1 " Auto Sudo if no r/w permission
let g:dashboard_default_executive = "telescope"
let g:doom_one_terminal_colors = v:true
let g:doom_one_cursor_coloring = v:true


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
set iskeyword+=-
set signcolumn=yes
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable
set whichwrap+=<,>,h,l,[,] "GO to next/prev Line on End/Start of Line

set cursorline
hi CursorLineNr   term=bold ctermfg=Yellow gui=bold guifg=Yellow

colorscheme tokyonight-night
syntax enable

" file type recognition
filetype on
filetype plugin on
filetype indent on

" Setup NerdTree & File Explorer
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <silent><Space> :NnnPicker<CR>

" Setup Telescope / Findings
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
nnoremap <silent><leader>g <cmd> :LazyGit<CR>
nnoremap <silent><leader>t <cmd> :ToggleTerm direction="float"<CR>

"NavBar Mapping for next/prev/close
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

" Disable accidental Cursor Position on Windows Focus
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
" nnoremap <silent><Tab> za <CR>

" Train Tracks =)
nnoremap <silent><leader>k <CMD> :call train#show_matches(['w', 'j', 'b', 'e', '^', 'H', 'M', 'L', ']', '[', ']]', '{', '}', '[['])<CR>

" Setup Scrollbar
augroup ScrollbarInit
  autocmd!
  autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
  autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()
  autocmd WinLeave,BufLeave,BufWinLeave,FocusLost            * silent! lua require('scrollbar').clear()
augroup end

" Quickkeys for Opening this config File and Plugins VIM
nnoremap <silent><leader>vc <cmd> :e $MYVIMRC <CR>
nnoremap <silent><leader>vr <cmd> :source $MYVIMRC <CR> 
nnoremap <silent><leader>vp <cmd> :e $HOME/.config/nvim/vim-plug/plugins.vim <CR>

" Add Yank support to iterm2 Terminal in visual Mode 
xnoremap <silent><leader>c :OSCYankVisual <CR>

" Move lines quick up and down
nnoremap <silent><S-Up> :m .-2 <CR>
nnoremap <silent><S-Down> :m .+1 <CR>

" Center View when searching / jumping / doing stuff
nnoremap n nzzzv 
nnoremap N Nzzzv
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap <silent><Up> <Up>zz
nnoremap <silent><Down> <Down>zz

" Toogle Undotree Window
nnoremap <silent><leader>u :UndotreeToggle<CR> 

" Marks handling
nnoremap <silent><leader>ml :Telescope marks <CR>
nnoremap <silent><leader>md :delmarks A-Z0-9 <CR>

" Set special save comand for iterm integration
noremap  <silent><C-s> :w<CR>
inoremap <silent><C-s> <ESC>:w<CR>i

" Escape from Terminal
tnoremap <silent><leader>t <C-\><C-n>:ToggleTerm<CR>

" Auto open nvim-tree, when opening directory
function! OpenNvimTree()
  if argc() == 1 && isdirectory(argv()[0])
    NvimTreeFindFile
  endif
endfunction

autocmd VimEnter * silent call OpenNvimTree()


