local uv = vim.uv or vim.loop

local function register_local_parser(parser_config, name, path, filetype)
  local expanded = vim.fn.expand(path)
  if not uv.fs_stat(expanded) then
    return
  end

  parser_config[name] = {
    install_info = {
      path = expanded,
      files = { "src/parser.c" },
      -- 如果你的 grammar 仓库还带 scanner.c / scanner.cc，
      -- 这里改成例如：
      -- files = { "src/parser.c", "src/scanner.c" },
    },
    filetype = filetype,
  }
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      sync_install = false,
      auto_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

      register_local_parser(parser_config, "pss", "~/nvim_github/tree-sitter-pss", "pss")
      register_local_parser(parser_config, "systemverilog", "~/nvim_github/tree-sitter-systemverilog", "systemverilog")

      vim.treesitter.language.register("pss", { "pss" })
      vim.treesitter.language.register("systemverilog", { "systemverilog", "verilog" })

      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "andymass/vim-matchup",
    event = { "BufReadPost", "BufNewFile" },
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  {
    "echasnovski/mini.nvim",
    event = { "VeryLazy", "InsertEnter" },
    config = function()
      local pairs = require("mini.pairs")
      pairs.setup()
      pairs.unmap("i", "'", "''")
      pairs.unmap("i", "`", "``")

      require("mini.align").setup()
    end,
  },

  {
    "hat0uma/csvview.nvim",
    ft = { "csv", "tsv" },
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
    opts = {
      parser = {
        async_chunksize = 50,
        comments = { "#", "//", "--" },
        delimiter = {
          default = ";",
          ft = {
            tsv = "\t",
          },
        },
        quote_char = '"',
      },
      view = {
        min_column_width = 5,
        spacing = 2,
        display_mode = "highlight",
      },
      keymaps = {
        textobject_field_inner = { "if", mode = { "o", "x" } },
        textobject_field_outer = { "af", mode = { "o", "x" } },
        jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
        jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
        jump_next_row = { "<Enter>", mode = { "n", "v" } },
        jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
      },
    },
  },
}