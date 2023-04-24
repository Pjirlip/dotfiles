vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true


local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

require("mason").setup()
require("mason-lspconfig").setup()

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
    window = {
        border = "single"
    }
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
--_G.tab_complete = function()
--  if vim.fn.pumvisible() == 1 then
--    return t "<C-n>"
--  elseif vim.fn['vsnip#available'](1) == 1 then
--    return t "<Plug>(vsnip-expand-or-jump)"
--  elseif check_back_space() then
--    return t "<Tab>"
--  else
--    return vim.fn['compe#complete']()
--  end
--end
--_G.s_tab_complete = function()
-- if vim.fn.pumvisible() == 1 then
--    return t "<C-p>"
--  elseif vim.fn['vsnip#jumpable'](-1) == 1 then
--    return t "<Plug>(vsnip-jump-prev)"
--  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
--    return t "<S-Tab>"
--  end
--end

--vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
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
          open_mapping = [[<c-t>]],
          hide_numbers = true, 
          shade_filetypes = {},
          shade_terminals = true,
          shading_factor = 1, 
          start_in_insert = true,
          insert_mappings = true, 
          persist_size = true,
          direction = 'float',
          close_on_exit = true,
          shell = vim.o.shell,
          float_opts = {
            border = 'double',
            width=300,
            height=200,
            zindex=1
          }
    }

    local Terminal  = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new({ 
            cmd = "lazygit", 
            hidden = true, 
            direction = "float", 
            close_on_exit=true,
    })

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

require("nvim-tree").setup({
    sort_by = "case_sensitive",
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = false,
    },
    view = {
        side = "left",
        width = 30,
        cursorline = true
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true
    }
})

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

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require'cmp'

cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif vim.fn["vsnip#jumpable"](1) == 1 then
          feedkey("<Plug>(vsnip-jump-next)", "")
        elseif has_words_before() then
          cmp.complete()
        else
          fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
      end, {"i", "s"})

      -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
    }, {
      { name = 'buffer' },
    })
})



lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)


-- Setup LSP Servers -- 
lspconfig.tsserver.setup({}) 
lspconfig.rust_analyzer.setup({})


