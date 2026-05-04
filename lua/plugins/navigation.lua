local util = require("core.util")

return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      {
        "<C-i>",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Telescope buffers",
      },
      {
        "<C-p>",
        function()
          require("telescope.builtin").find_files({ cwd = util.project_root() })
        end,
        desc = "Telescope project files",
      },
      {
        "<C-g>",
        function()
          require("telescope.builtin").live_grep({ cwd = util.project_root() })
        end,
        desc = "Telescope project grep",
      },
      {
        "<leader>e",
        function()
          require("telescope.builtin").find_files({ cwd = util.buffer_dir() })
        end,
        desc = "Telescope buffer dir files",
      },
      {
        "<leader>g",
        function()
          require("telescope.builtin").live_grep({ cwd = util.buffer_dir() })
        end,
        desc = "Telescope buffer dir grep",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    opts = function()
      local actions = require("telescope.actions")
      return {
        defaults = {
          file_ignore_patterns = { "sim/work.*" },
          path_display = { truncate = 3 },
          preview = false,
          mappings = {
            i = {
              ["<Esc>"] = actions.close,
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
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      pcall(telescope.load_extension, "fzf")
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeResize" },
    keys = {
      { "<leader>t", "<Cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
      { "<leader>+", "<Cmd>NvimTreeResize +10<CR>", desc = "Widen file tree" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      git = { enable = false },
      filters = { dotfiles = true },
      renderer = {
        icons = {
          show = {
            git = false,
          },
        },
      },
      update_focused_file = {
        enable = true,
      },
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", desc = "Tmux left" },
      { "<C-j>", "<Cmd>TmuxNavigateDown<CR>", desc = "Tmux down" },
      { "<C-k>", "<Cmd>TmuxNavigateUp<CR>", desc = "Tmux up" },
      { "<C-l>", "<Cmd>TmuxNavigateRight<CR>", desc = "Tmux right" },
      { "<C-\\>", "<Cmd>TmuxNavigatePrevious<CR>", desc = "Tmux previous" },
    },
  },
}
