local function lualine_opts()
  local colors = {
    bg = "#202328",
    fg = "#bbc2cf",
    yellow = "#ECBE7B",
    cyan = "#008080",
    green = "#98be65",
    orange = "#FF8800",
    violet = "#a9a1e1",
    magenta = "#c678dd",
    blue = "#51afef",
    red = "#ec5f67",
    grey = "#a0a1a7",
  }

  local function buffer_not_empty()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end

  local function wide_enough()
    return vim.fn.winwidth(0) > 80
  end

  local function mode_color()
    local map = {
      n = colors.magenta,
      i = colors.green,
      v = colors.blue,
      ["\22"] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.magenta,
      s = colors.orange,
      S = colors.orange,
      ["\19"] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.magenta,
      ce = colors.magenta,
      r = colors.cyan,
      rm = colors.cyan,
      ["r?"] = colors.cyan,
      ["!"] = colors.magenta,
      t = colors.magenta,
    }
    return { fg = map[vim.fn.mode()] or colors.fg }
  end

  return {
    options = {
      component_separators = "",
      section_separators = "",
      disabled_filetypes = {
        statusline = { "NvimTree" },
      },
      theme = {
        normal = { c = { fg = colors.fg, bg = colors.bg } },
        inactive = { c = { fg = colors.fg, bg = colors.bg } },
      },
      globalstatus = true,
    },
    sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        { "mode", color = mode_color, padding = { right = 1 } },
        { "filetype", cond = buffer_not_empty, color = { fg = colors.green, gui = "bold" } },
        { "filename", color = { fg = colors.magenta, gui = "bold" } },
        { "location" },
        { "progress", color = { fg = colors.fg, gui = "bold" } },
        { function() return "%=" end },
      },
      lualine_x = {
        { "o:encoding", fmt = string.upper, cond = wide_enough, color = { fg = colors.green, gui = "bold" } },
        { "fileformat", fmt = string.upper, icons_enabled = false, color = { fg = colors.green, gui = "bold" } },
        { "branch", icon = "", color = { fg = colors.violet, gui = "bold" } },
        {
          "diff",
          symbols = { added = " ", modified = "󰝤 ", removed = " " },
          diff_color = {
            added = { fg = colors.green },
            modified = { fg = colors.orange },
            removed = { fg = colors.red },
          },
          cond = wide_enough,
        },
      },
      lualine_y = {},
      lualine_z = {},
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        { "filename", path = 3, color = { fg = colors.grey } },
      },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
  }
end

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = lualine_opts,
  },
}
