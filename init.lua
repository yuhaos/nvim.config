-- Name: init.lua
-- Author: Yuhao Sun
-- Usage: This is the configuration for NVIM >= v0.10.0

-- map the leader key firstly, it might be used by many plugins
vim.g.mapleader = ","

-- enable this very early to avoid nvim loading the builtin tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set the file type for some types, using filetype insteand of creating autocmd
-- vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
--   pattern = {"*.pss"},
--   command = "setfiletype pss",
-- })
vim.filetype.add({
  extension = {
    v   = "systemverilog",
    vh  = "systemverilog",
    vp  = "systemverilog",
    sv  = "systemverilog",
    svi = "systemverilog",
    svh = "systemverilog",
    svp = "systemverilog",
    sva = "systemverilog",
    pss = "pss",
  }
})

-- general configurations
require("config.general")

require("config.lazy")
require('lualine').setup(require('config.evillualine'))
require('toggleterm').setup()
require('nvim-tree').setup {
  git = { enable = false },
  filters = { dotfiles = true }
}

-- solarized it done inside plugin
-- require('solarized').setup()
local nvim_set_hl = function(group_name, group_val, styles)
  if not group_val.link then
    local val = { fg = 'NONE', bg = 'NONE' }
    group_val = vim.tbl_extend('force', group_val, styles)
    vim.api.nvim_set_hl(0, group_name, vim.tbl_extend('force', val, group_val))
  else
    vim.api.nvim_set_hl(0, group_name, group_val)
  end
end
local s_palette = require('solarized.palette')
local s_config = require('solarized.config')
nvim_set_hl('WinSeparator', { link = 'LineNr' })
nvim_set_hl('Keyword', {fg = s_palette[s_config.palette].green}, s_config.styles.keywords)
nvim_set_hl('Type',    {fg = s_palette[s_config.palette].base1}, s_config.styles.keywords)

require('mini.align').setup()
local mp = require('mini.pairs')
mp.setup()
mp.unmap("i", "'", "''")
mp.unmap("i", '`', '``')

-- fugitive is not a lua plugin, will be loaded directly

-- telescope has "Configuration Recepes" in github
-- could not moved to lua/plugin/telescope.lua, the reason
-- is we need load telescope.actions, which is only available after
-- load for lua/plugin/telescope.lua
local actions = require("telescope.actions")
require("telescope").setup {
  defaults = {
    file_ignore_patterns = { "sim/work.*" },
    path_display = {truncate = 3},
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-j>"] = {
          actions.move_selection_next, type = "action",
          opts = { nowait = true, silent = true }
        },
        ["<C-k>"] = {
          actions.move_selection_previous, type = "action",
          opts = { nowait = true, silent = true }
        },
      },
    },
    -- disable preview for high performance
    preview = false,
  },
  pickers = {
    buffers = {
      mappings = {
        i = {
          -- close the buffer from telescope directly
          ["<C-d>"] = actions.delete_buffer
        }
      }
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").load_standalone({path = "~/.config/nvim/snippets/systemverilog.json"})
require("luasnip").env_namespace("MY", {vars = {
  USER_NAME = function()
    return os.getenv("USER")
  end,
  USER_HOME = function()
    return os.getenv("HOME")
  end,
  FILE_TYPE = function ()
    return vim.fn.expand("%:e")
  end
}})
require("luasnip").setup({
  region_check_events = "CursorHold,InsertLeave",
  delete_check_events = "TextChanged,InsertEnter",
})

require("nvim-treesitter").setup()
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.pss = {
  install_info = {
    url = "https://github.com/yuhaos/tree-sitter-pss.git", -- local path or git repo
    files = {"src/parser.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
  },
  filetype = "pss", -- if filetype does not match the parser name
}
parser_config.systemverilog = {
  install_info = {
    -- using local path, we need to rename the function name from tree-sitter-verilog to tree-sitter-systemverilog
    url = "~/nvim_github/tree-sitter-systemverilog", -- local path or git repo
    files = {"src/parser.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
  },
  filetype = "systemverilog", -- if filetype does not match the parser name
}

-- keymaps, set is after all plugin are loaded since some key mapping need the plugin's setup
require("config.keymaps")

--
