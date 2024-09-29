local opt = vim.opt

-- General

-- Set how many lines of history NVIM has to rememter
opt.history = 100

-- Show the line numaber
opt.number = true

-- Eable the ${VAR} usage in "gf" command
opt.isfname = opt.isfname + "{,},@"

-- Set to auto read when a file is chagned from the otuside
opt.autoread = ture

-- Set 8 lines tothe cursor - when moving vertically using j/k
opt.scrolloff = 8

-- Trn on the wild menu
opt.wildmenu = true
opt.wildmode = "list:longest,full"

-- use help wildcharm to details
-- set this to the tab could trigger wildcard expansion in the mapped keys such as <leader>l
opt.wildcharm = ('\t'):byte()

-- ignore compiled files, and VCS files (used for ctrlp also)
opt.wildignore = "*.o,*.pyc,*./simv.daidir/*,*/csrc/*,*/simv.vdb/*"

-- Always show current position
opt.ruler = true

-- height of the command bar
opt.cmdheight = 1

-- a buffer becomes hidden when it is abandoned
opt.hidden = true

-- configure backspace so it acts as it should at
opt.backspace = "eol,start,indent"

-- config wrap
opt.whichwrap = "<,>,h,l"

-- set searching optins
opt.ignorecase = true 
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- do not redraw while executing macros (good performance config)
opt.lazyredraw = true

-- for regular expression, turn magic on
opt.magic = true

-- show matching brackets when text indicator is over them
opt.showmatch = true

-- how many tenths of seconds to blink when matnching brackets
opt.mat = 2

-- no annoying sound on errors
opt.errorbells = false
opt.visualbell = false

-- font could not be configured since we are using NVIM without GUI
-- opt.encoding always be UTF-8, and we don't need to configure it
-- opt.ffs is "unix,dox,mac" by default, since we are always in linux, don't need to configure it again

-- Turn backup off, since most stuff is in SVN, git etc.
opt.backup = false
opt.wb = false
opt.swapfile = false

-- TAB key related
opt.smarttab = true
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2

-- disable line break since it's annoying in bash
-- line break on 140 characters ??
-- opt.lbr = true
-- opt.tw = 140
-- auto indent, smart indent, and wrap lines
opt.ai = true
-- opt.si = true
opt.wrap = true

-- enable mouse
opt.mouse:append("a")

-- using system clipboard
-- Warning: using clipboard will lead to messy code when copy or select 
-- so disable it
-- opt.clipboard:append("unnamedplus")

-- open new window in right/below default
opt.splitright = true
opt.splitbelow = true

-- set the fill char between the vertical split window
opt.fillchars = "vert: "

-- remember info about open buffers on close
-- opt.shada = "20,<50,s10"

