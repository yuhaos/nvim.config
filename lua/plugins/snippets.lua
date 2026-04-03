local uv = vim.uv or vim.loop

local function tab_forward()
  local ls = require("luasnip")
  if ls.expand_or_locally_jumpable() then
    ls.expand_or_jump()
    return ""
  end
  return "<Tab>"
end

local function tab_backward()
  local ls = require("luasnip")
  if ls.locally_jumpable(-1) then
    ls.jump(-1)
    return ""
  end
  return "<S-Tab>"
end

return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    keys = {
      { "<Tab>", tab_forward, expr = true, mode = { "i", "s" }, silent = true, desc = "Snippet expand/jump" },
      { "<S-Tab>", tab_backward, expr = true, mode = { "i", "s" }, silent = true, desc = "Snippet jump backward" },
      {
        "<C-g>",
        function()
          local ls = require("luasnip")
          if ls.choice_active() then
            ls.change_choice(1)
          end
        end,
        mode = { "i", "s" },
        silent = true,
        desc = "Snippet next choice",
      },
    },
    opts = {
      region_check_events = "CursorHold,InsertLeave",
      delete_check_events = "TextChanged,InsertEnter",
    },
    config = function(_, opts)
      local ls = require("luasnip")
      ls.setup(opts)

      require("luasnip.loaders.from_vscode").lazy_load()

      local standalone = vim.fn.expand("~/.config/nvim/snippets/systemverilog.json")
      if uv.fs_stat(standalone) then
        require("luasnip.loaders.from_vscode").load_standalone({ path = standalone })
      end

      ls.env_namespace("MY", {
        vars = {
          USER_NAME = function()
            return os.getenv("USER")
          end,
          USER_HOME = function()
            return os.getenv("HOME")
          end,
          FILE_TYPE = function()
            return vim.fn.expand("%:e")
          end,
        },
      })
    end,
  },
}
