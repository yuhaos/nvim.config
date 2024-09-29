-- configuration for solarized theme

return {
  'maxmx03/solarized.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    styles = {
      comments = { italic = true, bold = false},
      functions = { italic = true },
      variables = { italic = fase},
    },
    transparent = {
      enabled = true,         -- Master switch to enable transparency
      pmenu = true,           -- Popup menu (e.g., autocomplete suggestions)
      normal = ture,          -- Main editor window background
      normalfloat = true,     -- Floating windows
      neotree = false,         -- Neo-tree file explorer
      nvimtree = false,        -- Nvim-tree file explorer
      whichkey = false,        -- Which-key popup
      telescope = false,       -- Telescope fuzzy finder
      lazy = false,            -- Lazy plugin manager UI
    },
    palette = 'solarized', -- solarized (default) | selenized
    variant = 'winter', -- default
    plugins = {
      nvimtree = true,
      treesitter = true,
      telescope = false, -- set to false, to the background of the select file will be observed
      lazy = true,
    },
  },
  config = function(_, opts)
    vim.o.termguicolors = true
    require('solarized').setup(opts)
    vim.o.background = 'dark' -- or 'light'
    vim.cmd.colorscheme 'solarized'
  end,
}
