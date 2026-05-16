return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  event = {
    "BufReadPost",
    "BufNewFile",
  },
  dependencies = {
    "neovim-treesitter/treesitter-parser-registry",
  },
  config = function()
    require("nvim-treesitter").setup({
      install_dir = vim.fn.stdpath("config") .. "/treesitter",
    })

    vim.treesitter.language.register("systemverilog", { "systemverilog", "verilog" })
    vim.treesitter.language.register("pss", { "pss" })

    local group = vim.api.nvim_create_augroup("UserTreesitterMain", { clear = true })

    local function start_treesitter(buf)
      pcall(vim.treesitter.start, buf)

      local ft = vim.bo[buf].filetype
      if ft == "systemverilog" or ft == "verilog" or ft == "pss" then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end

    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = "*",
      callback = function(ev)
        start_treesitter(ev.buf)
      end,
    })

    start_treesitter(vim.api.nvim_get_current_buf())
  end,
}
