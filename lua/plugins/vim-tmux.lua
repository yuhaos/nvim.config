return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<C-h>", "<cmd>TmuxNavigateLeft<CR>", mode = "n", silent = true },
    { "<C-j>", "<cmd>TmuxNavigateDown<CR>", mode = "n", silent = true },
    { "<C-k>", "<cmd>TmuxNavigateUp<CR>", mode = "n", silent = true },
    { "<C-l>", "<cmd>TmuxNavigateRight<CR>", mode = "n", silent = true },
    { "<C-\\>", "<cmd>TmuxNavigatePrevious<CR>", mode = "n", silent = true },
  },
}
