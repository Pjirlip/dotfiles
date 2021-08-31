" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

   " File Explorer
    Plug 'scrooloose/NERDTree', { 'on': 'NERDTreeToggle' }

    " Add git Support for Nerdtree
    Plug 'Xuyuanp/nerdtree-git-plugin'

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

    " The new Nerdtree
    Plug 'kyazdani42/nvim-web-devicons' " for file icons
    Plug 'kyazdani42/nvim-tree.lua'

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
    Plug 'glepnir/lspsaga.nvim'

    " Auto Setup Language Servers
    Plug 'kabouzeid/nvim-lspinstall'

    " AutoCompletion
    Plug 'hrsh7th/nvim-compe'
    
    " Toggle a Terminal
    Plug 'akinsho/nvim-toggleterm.lua'

    " Buffer NAviagtion Bar on Top
    "Plug 'romgrk/barbar.nvim'
    Plug 'akinsho/bufferline.nvim'

    " Quick Comment Out/in Stuff
    Plug 'tpope/vim-commentary'

    " Add VSCode Like ymbols to AutoCompletion
    Plug 'onsails/lspkind-nvim'

    " Add Emmet_Like HTML Completion
    Plug 'mattn/emmet-vim'

    " Snippet Support
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'

    " EsLint Integration
    Plug 'dense-analysis/ale'

    " Better Register Management
    Plug 'gennaro-tedesco/nvim-peekup'

    " Show Hex Colors
    Plug 'norcalli/nvim-colorizer.lua'

    " Close Buffers nicely
    Plug 'moll/vim-bbye'

    " Word Highlight
    Plug 'yamatsum/nvim-cursorline'

    " LazyGit Integration
    Plug 'kdheepak/lazygit.nvim'

    " Vim fur Dummis
    Plug 'tjdevries/train.nvim'

    " Faster Search/Jump To in Files
    Plug 'ggandor/lightspeed.nvim'

    " Scrollbar for VIM
    Plug 'Xuyuanp/scrollbar.nvim'

    " Auto-Session
    Plug 'rmagatti/auto-session'

    " Auto Sudo File if no w/r permissions
    Plug 'lambdalisue/suda.vim'

    " Dashboard
    Plug 'glepnir/dashboard-nvim'

    " Symbols Outline
    Plug 'simrat39/symbols-outline.nvim'

    " Git Stuff 
    Plug 'airblade/vim-gitgutter'

    " Highlight Portion of Code
    Plug 'folke/twilight.nvim'
    
    " Ranger integration in VIM
    Plug 'rbgrouleff/bclose.vim'
    Plug 'francoiscabrol/ranger.vim'

call plug#end()

