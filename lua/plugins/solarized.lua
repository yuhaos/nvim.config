return {
  "maxmx03/solarized.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    styles = {
      comments = { italic = true, bold = false },
      functions = { italic = true },
      variables = { italic = false },
    },
    transparent = {
      enabled = true,
      pmenu = true,
      normal = true,
      normalfloat = true,
      neotree = false,
      nvimtree = false,
      whichkey = false,
      telescope = false,
      lazy = false,
    },
    palette = "solarized",
    variant = "winter",
    plugins = {
      nvimtree = true,
      treesitter = true,
      telescope = false,
      lazy = true,
    },
  },
  config = function(_, opts)
    vim.o.termguicolors = true
    require("solarized").setup(opts)
    vim.o.background = "dark"
    vim.cmd.colorscheme("solarized")

    local palette = require("solarized.palette")
    local config = require("solarized.config")
    local colors = palette[config.palette]

    vim.api.nvim_set_hl(0, "WinSeparator", { link = "LineNr" })
    vim.api.nvim_set_hl(0, "Keyword", vim.tbl_extend("force", { fg = colors.green }, config.styles.keywords))
    vim.api.nvim_set_hl(0, "Type", vim.tbl_extend("force", { fg = colors.base1 }, config.styles.keywords))
  end,
}
