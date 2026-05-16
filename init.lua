-- Neovim configuration for Nvim >= 0.10.

-- Set the leader before plugins and mappings are loaded.
vim.g.mapleader = ","

-- Disable optional remote providers that are not used by this config. This
-- avoids checkhealth warnings for missing language host packages.
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Disable netrw before nvim-tree is loaded.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("config.filetypes")
require("config.general")
require("config.lazy")
require("config.snippets").setup()

-- Some mappings use plugin commands, so load them after lazy.nvim setup.
require("config.keymaps")
