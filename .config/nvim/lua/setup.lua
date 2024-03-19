vim.g.nvim_tree_disable_netrw = 0
vim.g.nvim_tree_hijack_netrw = 0
--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.g.copilot_no_tab_map = true
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
vim.g.copilot_filetypes = {
    ["*"] = false,
    ["javascript"] = true,
    ["typescript"] = true,
    ["lua"] = true,
    ["rust"] = true,
    ["c"] = true,
    ["c#"] = true,
    ["c++"] = true,
    ["go"] = true,
    ["python"] = true,
}


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
    },
    sections = {lualine_c = {require('auto-session.lib').current_session_name}}
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


local wk = require("which-key")

wk.register({
    c = {
      name = "ChatGPT",
        c = { "<cmd>ChatGPT<CR>", "ChatGPT" },
        e = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction", mode = { "n", "v" } },
        g = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction", mode = { "n", "v" } },
        t = { "<cmd>ChatGPTRun translate<CR>", "Translate", mode = { "n", "v" } },
        k = { "<cmd>ChatGPTRun keywords<CR>", "Keywords", mode = { "n", "v" } },
        d = { "<cmd>ChatGPTRun docstring<CR>", "Docstring", mode = { "n", "v" } },
        a = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests", mode = { "n", "v" } },
        o = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code", mode = { "n", "v" } },
        s = { "<cmd>ChatGPTRun summarize<CR>", "Summarize", mode = { "n", "v" } },
        f = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs", mode = { "n", "v" } },
        x = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code", mode = { "n", "v" } },
        r = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit", mode = { "n", "v" } },
        l = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis", mode = { "n", "v" } },
      }
})

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end


--vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})


require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true
    }
}

if pcall(require, "toggleterm") == true then 
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
    hijack_netrw = false,
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

-- Auto Close NVIM Tree if last open Buffer:
local function tab_win_closed(winnr)
  local api = require"nvim-tree.api"
  local tabnr = vim.api.nvim_win_get_tabpage(winnr)
  local bufnr = vim.api.nvim_win_get_buf(winnr)
  local buf_info = vim.fn.getbufinfo(bufnr)[1]
  local tab_wins = vim.tbl_filter(function(w) return w~=winnr end, vim.api.nvim_tabpage_list_wins(tabnr))
  local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
  if buf_info.name:match(".*NvimTree_%d*$") then            -- close buffer was nvim tree
    -- Close all nvim tree on :q
    if not vim.tbl_isempty(tab_bufs) then                      -- and was not the last window (not closed automatically by code below)
      api.tree.close()
    end
  else                                                      -- else closed buffer was normal buffer
    if #tab_bufs == 1 then                                    -- if there is only 1 buffer left in the tab
      local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
      if last_buf_info.name:match(".*NvimTree_%d*$") then       -- and that buffer is nvim tree
        vim.schedule(function ()
          if #vim.api.nvim_list_wins() == 1 then                -- if its the last buffer in vim
            vim.cmd "quit"                                        -- then close all of vim
          else                                                  -- else there are more tabs open
            vim.api.nvim_win_close(tab_wins[1], true)             -- then close only the tab
          end
        end)
      end
    end
  end
end

vim.api.nvim_create_autocmd("WinClosed", {
  callback = function ()
    local winnr = tonumber(vim.fn.expand("<amatch>"))
    vim.schedule_wrap(tab_win_closed(winnr))
  end,
  nested = true
})

vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    local invalid_win = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:match("NvimTree_") ~= nil then
        table.insert(invalid_win, w)
      end
    end
    if #invalid_win == #wins - 1 then
      -- Should quit, so we close all invalid windows.
      for _, w in ipairs(invalid_win) do vim.api.nvim_win_close(w, true) end
    end
  end
})


vim.opt.listchars = {
    eol = "↴",
}

if pcall(require, "ibl") == true then 
    require("ibl").setup()
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


require("nnn").setup({
    explorer = {
        cmd = "nnn -aHPp",
        fullscreen = false,
    },
    picker = {
        cmd = "tmux new-session nnn -aHPp",
        fullscreen = false
    },
    replace_netrw = "picker"
})

require('dashboard').setup {
      theme = 'hyper',
      config = {
      week_header = {
       enable = true,
      },
      project = { enable = true, limit = 8, icon = 'your icon', label = '', action = "lua require('auto-session.session-lens').list_session" },
      packages = { enable = true },
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
local lspkind = require('lspkind')

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
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text",
            ellipsis_char = '...',
            max_width = 50,
            symbol_map = { Copilot = "" }
        })
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        local copilot_keys = vim.fn['copilot#Accept']()
        if cmp.visible() then
          cmp.select_next_item()
        elseif vim.fn["vsnip#jumpable"](1) == 1 then
          feedkey("<Plug>(vsnip-jump-next)", "")
        elseif has_words_before() then
          cmp.complete()
        elseif copilot_keys ~= '' and type(copilot_keys) == 'string' then
            vim.api.nvim_feedkeys(copilot_keys, 'i', true)
        else
          fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
      end, {"i", "s"})

      -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp', group_index = 2, max_item_count = 5},
      { name = "path", group_index = 3, max_item_count = 2},
      { name = 'vsnip', grop_index = 3 },
      { name = 'buffer', group_index = 4, max_item_count = 3}
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
lspconfig.cssls.setup({})
lspconfig.astro.setup({})


vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Displays hover information about the symbol under the cursor
    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

    -- Jump to the definition
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

    -- Jump to declaration
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

    -- Lists all the implementations for the symbol under the cursor
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

    -- Jumps to the definition of the type symbol
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

    -- Lists all the references 
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

    -- Displays a function's signature information
    bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

    -- Renames all references to the symbol under the cursor
    bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

    -- Selects a code action available at the current cursor position
    bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

    -- Show diagnostics in a floating window
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

    -- Move to the previous diagnostic
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

    -- Move to the next diagnostic
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  end
})


require('github-theme').setup()

-- Auto-Session Setup
if pcall(require, "auto-session") then
  require("auto-session").setup({
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Downloads", "/"},
        session_lens = {
            buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
            load_on_setup = true,
            theme_conf = { border = true },
            previewer = false,
        },
  })
end

-- Quit Telescope wiht single ESC
local actions = require("telescope.actions")

require("telescope").setup({
    defaults = {
        file_ignore_patterns = {
            "node_modules", "build", "dist", "yarn.lock", ".git", ".cache", ".idea", ".vscode", ".DS_Store", ".next", ".nuxt", ".github", ".gitlab", ".gitattributes", ".gitmodules", ".gitkeep", ".gitconfig"
        },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            '--hidden'
        },
        pickers = {
            find_files = {
                no_ignore=true,
                hidden = true,
            },
        },
        mappings = {
            i = {
                ["<esc>"] = actions.close,
            },
        },
    },
})

-- Acccept Copilot Suggestion or Move Right
vim.api.nvim_set_keymap('i', '<Right>', "v:lua.accept_copilot_suggestion_or_move_right()", {expr = true, noremap = true})

function _G.accept_copilot_suggestion_or_move_right()
  local copilot_suggestion = vim.fn['copilot#Accept']()
  if copilot_suggestion ~= '' then
    return copilot_suggestion
  else 
    return t("<Right>")
  end
end

