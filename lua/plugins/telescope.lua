return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  config = function()
    local actions = require("telescope.actions")
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        file_ignore_patterns = { "sim/work.*" },
        path_display = { truncate = 3 },
        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<C-j>"] = {
              actions.move_selection_next,
              type = "action",
              opts = { nowait = true, silent = true },
            },
            ["<C-k>"] = {
              actions.move_selection_previous,
              type = "action",
              opts = { nowait = true, silent = true },
            },
          },
        },
        preview = false,
      },
      pickers = {
        buffers = {
          mappings = {
            i = {
              ["<C-d>"] = actions.delete_buffer,
            },
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    telescope.load_extension("fzf")
  end,
}
