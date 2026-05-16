local opt = vim.opt

-- Command and UI behavior.
opt.history = 100
opt.number = true
opt.isfname = opt.isfname + "{,},@"
opt.autoread = true
opt.scrolloff = 8
opt.wildmenu = true
opt.wildmode = "list:longest,full"
opt.wildcharm = ('\t'):byte()
opt.wildignore = "*.o,*.pyc,*./simv.daidir/*,*/csrc/*,*/simv.vdb/*"
opt.ruler = true
opt.cmdheight = 1
opt.hidden = true
opt.backspace = "eol,start,indent"
opt.whichwrap = "<,>,h,l"

-- Search.
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.magic = true

-- Editing feedback.
opt.lazyredraw = true
opt.showmatch = true
opt.mat = 2
opt.errorbells = false
opt.visualbell = false

-- Files.
opt.backup = false
opt.wb = false
opt.swapfile = false

-- Indentation.
opt.smarttab = true
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.ai = true
opt.wrap = true

-- Window behavior.
opt.mouse:append("a")
opt.splitright = true
opt.splitbelow = true
opt.fillchars = "vert: "
