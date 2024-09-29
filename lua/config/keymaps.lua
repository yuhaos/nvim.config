-- This file sets the keymap
-- some keymap might require plugins funciton. so this file is loaded after the lazy
-- the leader key should be setted before load any plugin, so it is moved to the init.lua

local keymap = vim.keymap

-------------------------------------------
-- visual mode
-------------------------------------------
-- move lines
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-------------------------------------------
-- command mode
-------------------------------------------
keymap.set("c", "<C-a>", "<HOME>")
keymap.set("c", "<C-e>", "<END>")

-------------------------------------------
-- insert mode
-------------------------------------------
-- move cursor as emacs
keymap.set("i", "<C-k>", "<UP>")
keymap.set("i", "<C-j>", "<DOWN>")
keymap.set("i", "<C-a>", "<HOME>")
keymap.set("i", "<C-e>", "<END>")
keymap.set("i", "<C-h>", "<LEFT>")
keymap.set("i", "<C-l>", "<RIGHT>")

-------------------------------------------
-- normal mode
-------------------------------------------
-- disable the highlight
keymap.set("n", "<leader><CR>", ":nohl<CR>")

-- treat ong lines as break lines (useful when moving around in them)
keymap.set("n", "j", "gj")
keymap.set("n", "k", "gk")

-- map <space> to / (search), and ctrl-<space> to ? (backwrads search)
keymap.set("n", "<SPACE>", "/")
keymap.set("n", "<C-SPACE>", "?")

-- smart way to move between windows
-- using plugin to move between windows
-- keymap.set("n", "<C-j>", "<C-w>j")
-- keymap.set("n", "<C-k>", "<C-w>k")
-- keymap.set("n", "<C-h>", "<C-w>h")
-- keymap.set("n", "<C-l>", "<C-w>l")

-- split/close multiple windows
keymap.set("n", "<leader>1", "<C-w>o")
keymap.set("n", "<leader>2", ":sp<CR>")
keymap.set("n", "<leader>3", ":vs<CR>")

-- switch CWD to the directory of the open buffer
-- <TAB> is used to expand %:h automatically
-- using %:p:h instead of %:h, the reason is if current buffer directory is just "."
-- and using %:h, <TAB> will just ask for snip, and will not expand %:h
keymap.set("n", "<leader>cd", ":cd %:p:h<TAB><CR>")
-- show current buffer files path
keymap.set("n", "<leader>u", ":echo expand('%:p:h')<CR>")
-- edit files in the same directory with the buffer files
keymap.set("n", "<leader>b", ":e %:p:h<TAB>")

-- remap vim 0 to first non-blank character
keymap.set("n", "0", "^")

-- fast saving
keymap.set("n", "<leader>w", ":w<cr>")
-- could not use map to wq, if the file is read only, it will report errors
keymap.set("n", "<leader>q", ":q<cr>")

-- folder
keymap.set("n", "zm", "zM")
keymap.set("n", "zr", "zR")

-------------------------------------------
-- plugin mode
-------------------------------------------
-- some plusargs need specified setting
local tb = require('telescope.builtin')
local ls = require('luasnip')
-- check wheter we are inside git repo
local function get_git_root(start_dir)
  local dot_git_path = vim.fn.finddir(".git", start_dir .. ";")
  if string.len(dot_git_path) == 0 then
    return nil
  else
    return vim.fn.fnamemodify(dot_git_path, ":h")
  end
end

-- function related to telescope
keymap.set("n", "<C-i>", tb.buffers, {silent = true})
keymap.set("n", "<C-p>", function() tb.find_files({ cwd = get_git_root(vim.loop.cwd()), }) end, {silent = true})
keymap.set("n", "<C-g>", function() tb.live_grep({ cwd = get_git_root(vim.loop.cwd()), }) end, {silent = true})
keymap.set("n", "<leader>e", function() tb.find_files({ cwd = get_git_root(".") or "%:p:h", }) end, {silent = true})
keymap.set("n", "<leader>g", function() tb.live_grep({ cwd = get_git_root(".") or "%:p:h", }) end, {silent = true})

-- function related to vim-tmux navigate
keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", {silent = true})
keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", {silent = true})
keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", {silent = true})
keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", {silent = true})
keymap.set("n", "<C-\\>", ":TmuxNavigatePrevious<CR>", {silent = true})

-- function related to nvim-tree
keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>", {silent = true})
keymap.set("n", "<leader>+", ":NvimTreeResize +10<CR>", {silent = true})

-- super-TAB, for luasnip
keymap.set("i", "<TAB>", ls.expand_or_jump, {silent = true})
keymap.set("s", "<TAB>", function() ls.jump(1) end, {silent = true})

keymap.set({"i", "s"}, "<C-g>", function()
  if ls.choice_active() then
    ls.change_choice(1)
    return true
  end
  -- local r_key = vim.api.nvim_replace_termcodes("<C-n>", true, false, true)
  -- vim.api.nvim_feedkeys(r_key, "i", true)
end, {silent = true}
)

keymap.set("n", "<leader>r", "<Cmd>ToggleTerm<CR>", {})
keymap.set("t", "<ESC>", "<Cmd>ToggleTerm<CR>", {})
keymap.set("t", "<C-h>", "<Cmd>wincmd h<CR>", {})
keymap.set("t", "<C-j>", "<Cmd>wincmd j<CR>", {})
keymap.set("t", "<C-k>", "<Cmd>wincmd k<CR>", {})
keymap.set("t", "<C-l>", "<Cmd>wincmd l<CR>", {})

-- EOF
