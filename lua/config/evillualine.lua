-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
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

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    component_separators = "",
    section_separators = "",
    disabled_filetypes = { "NvimTree" },
    theme = {
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

local function ins_left_inactive(component)
  table.insert(config.inactive_sections.lualine_c, component)
end

ins_left({
  "mode",
  color = function()
    local mode_color = {
      n = colors.magenta,
      i = colors.green,
      v = colors.blue,
      [""] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.magenta,
      s = colors.orange,
      S = colors.orange,
      [""] = colors.orange,
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
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { right = 1 },
})

ins_left({
  "filetype",
  cond = conditions.buffer_not_empty,
  color = { fg = colors.green, gui = "bold" },
})

ins_left({
  "filename",
  color = { fg = colors.magenta, gui = "bold" },
})

ins_left_inactive({
  "filename",
  path = 3,
  color = { fg = colors.grey },
})

ins_left({ "location" })

ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })

ins_left({
  function()
    return "%="
  end,
})

ins_right({
  "o:encoding",
  fmt = string.upper,
  cond = conditions.hide_in_width,
  color = { fg = colors.green, gui = "bold" },
})

ins_right({
  "fileformat",
  fmt = string.upper,
  icons_enabled = false,
  color = { fg = colors.green, gui = "bold" },
})

ins_right({
  "branch",
  icon = "",
  color = { fg = colors.violet, gui = "bold" },
})

ins_right({
  "diff",
  symbols = { added = " ", modified = "󰝤 ", removed = " " },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
})

return config
