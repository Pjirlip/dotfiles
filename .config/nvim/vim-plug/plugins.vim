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

    " Packger for LSP Server and more 
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'

    " Autoformatter
    Plug 'mhartington/formatter.nvim'

    " AutoCompletion
    Plug 'hrsh7th/nvim-compe'
    
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

    " Snippet Support
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'

    " EsLint Integration
    Plug 'dense-analysis/ale', Cond(!exists('g:vscode'))

    " Better Register Management
    Plug 'gennaro-tedesco/nvim-peekup', Cond(!exists('g:vscode'))

    " Show Hex Colors
    Plug 'norcalli/nvim-colorizer.lua'

    " Close Buffers nicely
    Plug 'moll/vim-bbye'

    " Word Highlight
    Plug 'yamatsum/nvim-cursorline', Cond(!exists('g:vscode'))

    " LazyGit Integration
    Plug 'kdheepak/lazygit.nvim', Cond(!exists('g:vscode'))

    " Vim fur Dummis
    Plug 'tjdevries/train.nvim'

    " Faster Search/Jump To in Files
    "Plug 'ggandor/lightspeed.nvim'

    " Scrollbar for VIM
    Plug 'Xuyuanp/scrollbar.nvim', Cond(!exists('g:vscode'))

    " Auto-Session
    Plug 'rmagatti/auto-session', Cond(!exists('g:vscode'))

    " Auto Sudo File if no w/r permissions
    Plug 'lambdalisue/suda.vim', Cond(!exists('g:vscode'))

    " Dashboard
    Plug 'glepnir/dashboard-nvim', Cond(!exists('g:vscode'))

    " Symbols Outline
    Plug 'simrat39/symbols-outline.nvim'

    " Highlight Portion of Code
    Plug 'folke/twilight.nvim'
    
    " Ranger integration in VIM
    "Plug 'rbgrouleff/bclose.vim'

    " Yank from VISUAL Mode to ITerm2 Clipboard by OSC52
    Plug 'ojroques/vim-oscyank', Cond(!exists('g:vscode'))

    " JS Import Support
    Plug 'ludovicchabant/vim-gutentags', Cond(!exists('g:vscode'))
    Plug 'kristijanhusak/vim-js-file-import', {'do': 'npm install'}, Cond(!exists('g:vscode'))

    " NNN Filebrwoser support
    Plug 'luukvbaal/nnn.nvim'

    " Neovim Notify Plugin
    Plug 'rcarriga/nvim-notify'

    " Undotree Plugin
    Plug 'mbbill/undotree'
    
    " Better marks
    Plug 'chentoast/marks.nvim'

    "Keep first line of functions visible for better block visibility
    Plug 'wellle/context.vim'


call plug#end()
