return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  cmd = "Telescope",
  keys = function()
    local function get_git_root(start_dir)
      local dot_git_path = vim.fn.finddir(".git", start_dir .. ";")
      if dot_git_path == "" then
        return nil
      end

      return vim.fn.fnamemodify(dot_git_path, ":h")
    end

    local function builtin(name)
      return function()
        require("telescope.builtin")[name]()
      end
    end

    return {
      { "<C-i>", builtin("buffers"), mode = "n", silent = true },
      {
        "<C-p>",
        function()
          require("telescope.builtin").find_files({ cwd = get_git_root(vim.loop.cwd()) })
        end,
        mode = "n",
        silent = true,
      },
      {
        "<C-g>",
        function()
          require("telescope.builtin").live_grep({ cwd = get_git_root(vim.loop.cwd()) })
        end,
        mode = "n",
        silent = true,
      },
      {
        "<leader>e",
        function()
          require("telescope.builtin").find_files({ cwd = get_git_root(".") or "%:p:h" })
        end,
        mode = "n",
        silent = true,
      },
      {
        "<leader>g",
        function()
          require("telescope.builtin").live_grep({ cwd = get_git_root(".") or "%:p:h" })
        end,
        mode = "n",
        silent = true,
      },
    }
  end,
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
