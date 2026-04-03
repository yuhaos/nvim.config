local opt = vim.opt

vim.o.background = "dark"
opt.termguicolors = true

opt.history = 100
opt.number = true
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.cmdheight = 1
opt.updatetime = 250

opt.isfname:append({ "{", "}", "@" })
opt.autoread = true

opt.wildmenu = true
opt.wildmode = "list:longest,full"
opt.wildcharm = string.byte("\t")
opt.wildignore = "*.o,*.pyc,*/simv.daidir/*,*/csrc/*,*/simv.vdb/*"

opt.ruler = true
opt.hidden = true
opt.backspace = { "indent", "eol", "start" }
opt.whichwrap:append("<,>,h,l")

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.lazyredraw = true
opt.magic = true
opt.showmatch = true
opt.matchtime = 2
opt.errorbells = false
opt.visualbell = false

opt.backup = false
opt.writebackup = false
opt.swapfile = false

opt.smarttab = true
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.autoindent = true
opt.wrap = true

opt.mouse:append("a")

opt.splitright = true
opt.splitbelow = true
opt.fillchars = { vert = " " }
