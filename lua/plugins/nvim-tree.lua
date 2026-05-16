return {
  "nvim-tree/nvim-tree.lua",
  cmd = {
    "NvimTreeToggle",
    "NvimTreeResize",
  },
  keys = {
    { "<leader>t", "<cmd>NvimTreeToggle<CR>", mode = "n", silent = true },
    { "<leader>+", "<cmd>NvimTreeResize +10<CR>", mode = "n", silent = true },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    git = { enable = false },
    filters = { dotfiles = true },
  },
}
