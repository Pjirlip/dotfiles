
" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

function! PlugLoaded(name)
    return (
        \ has_key(g:plugs, a:name) &&
        \ isdirectory(g:plugs[a:name].dir) &&
        \ stridx(&rtp, g:plugs[a:name].dir) >= 0)
endfunction

call plug#begin('~/.config/nvim/autoload/plugged')

    " Monokai Theme (Because mike loves ist)
    Plug 'tanvirtin/monokai.nvim'

    " Tokoyonight Color Theme
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

    " Materialize Color Theme
    Plug 'kaicataldo/material.vim', { 'branch': 'main' }
    
    " Doom One Color Theme
    Plug 'NTBBloodbath/doom-one.nvim'


    " File Parser for syntax highlighting based on language
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    Plug 'kyazdani42/nvim-web-devicons' " for file icons
    Plug 'kyazdani42/nvim-tree.lua', Cond(!exists('g:vscode'))

    " Show possible Key Mappings
    Plug 'folke/which-key.nvim'
    " Wanted by Which-key
    Plug 'echasnovski/mini.nvim', { 'branch': 'stable' }

    " Status Line
    Plug 'hoob3rt/lualine.nvim'

    " Add IndentLines to Window
    Plug 'lukas-reineke/indent-blankline.nvim'

    " Fuzzy Find
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    " Inline LSP Diagnostigs
    Plug 'folke/trouble.nvim'

    " Better LSP Support (Floating Windows)
    Plug 'neovim/nvim-lspconfig'
    Plug 'glepnir/lspsaga.nvim', Cond(!exists('g:vscode'))
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'nvim-lua/diagnostic-nvim'

    " Autoformatter
    Plug 'mhartington/formatter.nvim'

    " Toggle a Terminal
    Plug 'akinsho/nvim-toggleterm.lua', Cond(!exists('g:vscode'))

    " Buffer NAviagtion Bar on Top
    "Plug 'romgrk/barbar.nvim'
    Plug 'akinsho/bufferline.nvim', Cond(!exists('g:vscode'))

    " Quick Comment Out/in Stuff
    Plug 'tpope/vim-commentary'

    " Add VSCode Like ymbols to AutoCompletion
    Plug 'onsails/lspkind-nvim', Cond(!exists('g:vscode'))

    " Add Emmet_Like HTML Completion
    Plug 'mattn/emmet-vim'

    " EsLint Integration
    Plug 'dense-analysis/ale', Cond(!exists('g:vscode'))

    " Better Register Management
    "Plug 'gennaro-tedesco/nvim-peekup', Cond(!exists('g:vscode'))

    " Show Hex Colors
    Plug 'norcalli/nvim-colorizer.lua'

    " Close Buffers nicely
    Plug 'moll/vim-bbye'

    " Word Highlight
    Plug 'yamatsum/nvim-cursorline', Cond(!exists('g:vscode'))

    " LazyGit Integration
    Plug 'kdheepak/lazygit.nvim', Cond(!exists('g:vscode'))

    " Faster Search/Jump To in Files
    "Plug 'ggandor/lightspeed.nvim'

    " Scrollbar for VIM
    Plug 'Xuyuanp/scrollbar.nvim', Cond(!exists('g:vscode'))

    " Auto Sudo File if no w/r permissions
    Plug 'lambdalisue/suda.vim', Cond(!exists('g:vscode'))
    " Dashboard
    Plug 'glepnir/dashboard-nvim', Cond(!exists('g:vscode'))

    " Symbols Outline
    Plug 'simrat39/symbols-outline.nvim'

    " Highlight Portion of Code
    Plug 'folke/twilight.nvim'
    
    " Yank from VISUAL Mode to ITerm2 Clipboard by OSC52
    Plug 'ojroques/vim-oscyank', Cond(!exists('g:vscode'))

    " JS Import Support
    Plug 'kristijanhusak/vim-js-file-import', {'do': 'npm install'}, Cond(!exists('g:vscode'))

    " NNN Filebrwoser support
    Plug 'luukvbaal/nnn.nvim'

    " Neovim Notify Plugin
    Plug 'rcarriga/nvim-notify'

    " Undotree Plugin
    Plug 'mbbill/undotree'
    
    " Better marks
    Plug 'chentoast/marks.nvim'

    " Rusttools
    Plug 'simrat39/rust-tools.nvim'

    " CTag Mangament
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'preservim/tagbar'

    " "Good" White theme for presentations
    Plug 'projekt0n/github-nvim-theme', { 'tag': 'v0.0.7' }

    Plug 'MunifTanjim/nui.nvim'
    
    " Auto Sessions
    Plug 'rmagatti/auto-session'

    Plug 'github/copilot.vim'

    " Rsync for local editing
    Plug 'kenn7/vim-arsync'
    Plug 'prabirshrestha/async.vim'

    Plug 'kylechui/nvim-surround'

    " Allow Project Based Neovim tweaks by .lvimrc Files
    Plug 'embear/vim-localvimrc'

call plug#end()

