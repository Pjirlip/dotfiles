

require("mason").setup()

require("formatter").setup {
    ["*"] = {
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
}

require('lualine').setup {
    options = {
      theme = 'tokyonight'
    }
  }
  
require("nvim-web-devicons").setup {
   default = true;
}
  
require("trouble").setup {}
  

require("which-key").setup{
    triggers_blacklist = {
    i = { ","},
  },
}


require('compe').setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn['vsnip#available'](1) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn['vsnip#jumpable'](-1) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})


require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true
    }
}

if vim.fn.PlugLoaded("toggleterm") == true then
    require("toggleterm").setup{
        size = 20,
          open_mapping = [[<C-t>]],
          hide_numbers = true, 
          shade_filetypes = {},
          shade_terminals = true,
          shading_factor = 1, 
          start_in_insert = true,
          insert_mappings = true, 
          persist_size = true,
          direction = 'horizontal',
          close_on_exit = true,
          shell = vim.o.shell,
          float_opts = {
            border = 'double',
            winblend = 0,
            highlights = {
              border = "Normal",
              background = "Normal",
            }
          }
    }

    local Terminal  = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float"})

    function _lazygit_toggle()
        lazygit:toggle()
    end
end

if vim.fn.PlugLoaded("lspkind") == true then
    require('lspkind').init({
        with_text = true,
        preset = 'default',
        symbol_map = {
          Field = "",
          Class = "",
          Property =  "",
        }
    })
end

require("bufferline").setup{
      options={
        diagnostics = "nvim_lsp",
        separator_style = "slant",
        always_show_bufferline = true,
        show_close_icon = true,
        show_buffer_close_icons = true,
        show_tab_indicators = true,
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "left"
            }
        }
      }
}

vim.opt.listchars = {
    eol = "↴",
}

if vim.fn.PlugLoaded("indent_blank") == true then
    require("indent_blankline").setup {
        show_end_of_line = true,
        show_current_context = true,
        space_char_blankline = " ",
    }
end

require'marks'.setup {
  default_mappings = true,
  builtin_marks = { ".", "<", ">", "^" },
  cyclic = true,
  force_write_shada = false,
  refresh_interval = 250,
  sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
  excluded_filetypes = {},
  mappings = {}
}


require("nnn").setup()

require('dashboard').setup {
      theme = 'hyper',
      config = {
      week_header = {
       enable = true,
      },
      shortcut = {
        { desc = ' Update', group = '@property', action = 'PlugUpdate', key = 'u' },
        {
          icon = ' ',
          icon_hl = '@variable',
          desc = 'Files',
          group = 'Label',
          action = 'Telescope find_files',
          key = 'f',
        },
     },
    },
}


