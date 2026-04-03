vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Disable netrw early because nvim-tree replaces it.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("core.options")
require("core.filetypes")
require("core.autocmds")
require("core.keymaps")
require("core.lazy")
