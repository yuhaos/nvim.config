local keymap = vim.keymap

local silent = { silent = true }

-- Visual mode.
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Command mode.
keymap.set("c", "<C-a>", "<HOME>")
keymap.set("c", "<C-e>", "<END>")

-- Insert mode.
keymap.set("i", "<C-k>", "<UP>")
keymap.set("i", "<C-j>", "<DOWN>")
keymap.set("i", "<C-a>", "<HOME>")
keymap.set("i", "<C-e>", "<END>")
keymap.set("i", "<C-h>", "<LEFT>")
keymap.set("i", "<C-l>", "<RIGHT>")

-- Normal mode.
keymap.set("n", "<leader><CR>", ":nohl<CR>", silent)
keymap.set("n", "j", "gj")
keymap.set("n", "k", "gk")
keymap.set("n", "<SPACE>", "/")
keymap.set("n", "<C-SPACE>", "?")

keymap.set("n", "<leader>1", "<C-w>o")
keymap.set("n", "<leader>2", ":sp<CR>")
keymap.set("n", "<leader>3", ":vs<CR>")

-- Use <Tab> to expand %:p:h in the command line.
keymap.set("n", "<leader>cd", ":cd %:p:h<TAB><CR>")
keymap.set("n", "<leader>u", ":echo expand('%:p:h')<CR>")
keymap.set("n", "<leader>b", ":e %:p:h<TAB>")

keymap.set("n", "0", "^")
keymap.set("n", "<leader>w", ":w<cr>")
keymap.set("n", "<leader>q", ":q<cr>")

keymap.set("n", "zm", "zM")
keymap.set("n", "zr", "zR")

-- Plugin mappings.
local telescope = require("telescope.builtin")

local function get_git_root(start_dir)
  local dot_git_path = vim.fn.finddir(".git", start_dir .. ";")
  if dot_git_path == "" then
    return nil
  end

  return vim.fn.fnamemodify(dot_git_path, ":h")
end

keymap.set("n", "<C-i>", telescope.buffers, silent)
keymap.set("n", "<C-p>", function()
  telescope.find_files({ cwd = get_git_root(vim.loop.cwd()) })
end, silent)
keymap.set("n", "<C-g>", function()
  telescope.live_grep({ cwd = get_git_root(vim.loop.cwd()) })
end, silent)
keymap.set("n", "<leader>e", function()
  telescope.find_files({ cwd = get_git_root(".") or "%:p:h" })
end, silent)
keymap.set("n", "<leader>g", function()
  telescope.live_grep({ cwd = get_git_root(".") or "%:p:h" })
end, silent)

keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", silent)
keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", silent)
keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", silent)
keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", silent)
keymap.set("n", "<C-\\>", ":TmuxNavigatePrevious<CR>", silent)

keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>", silent)
keymap.set("n", "<leader>+", ":NvimTreeResize +10<CR>", silent)
