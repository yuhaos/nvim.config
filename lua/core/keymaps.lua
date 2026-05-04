local keymap = vim.keymap

local function map(mode, lhs, rhs, opts)
  local base = { silent = true }
  if opts then
    base = vim.tbl_extend("force", base, opts)
  end
  keymap.set(mode, lhs, rhs, base)
end

local function close_other_windows()
  local current = vim.api.nvim_get_current_win()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if win ~= current then
      local buf = vim.api.nvim_win_get_buf(win)
      local ft = vim.bo[buf].filetype
      if ft ~= "NvimTree" then
        pcall(vim.api.nvim_win_close, win, false)
      end
    end
  end
end

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("c", "<C-a>", "<Home>")
map("c", "<C-e>", "<End>")

map("i", "<C-k>", "<Up>")
map("i", "<C-j>", "<Down>")
map("i", "<C-a>", "<Home>")
map("i", "<C-e>", "<End>")
map("i", "<C-h>", "<Left>")
map("i", "<C-l>", "<Right>")

map("n", "<leader><CR>", "<Cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
map("n", "j", "gj")
map("n", "k", "gk")
map("n", "<Space>", "/")
map("n", "<C-Space>", "?")
map("n", "<leader>1", close_other_windows, { desc = "Keep only current window" })
map("n", "<leader>2", "<Cmd>split<CR>", { desc = "Horizontal split" })
map("n", "<leader>3", "<Cmd>vsplit<CR>", { desc = "Vertical split" })
map("n", "<leader>cd", function()
  local dir = vim.fn.expand("%:p:h")
  vim.cmd.cd(dir)
  vim.notify("cd " .. vim.fn.getcwd(), vim.log.levels.INFO, { title = "cwd changed" })
end, { desc = "Change cwd to buffer dir" })
map("n", "<leader>u", function()
  print(vim.fn.expand("%:p:h"))
end, { desc = "Print buffer directory" })
map("n", "<leader>b", ":edit %:p:h/", { desc = "Edit file in buffer directory" })
map("n", "0", "^")
map("n", "<leader>w", "<Cmd>write<CR>", { desc = "Write buffer" })
map("n", "<leader>q", "<Cmd>quit<CR>", { desc = "Quit window" })
map("n", "zm", "zM")
map("n", "zr", "zR")
