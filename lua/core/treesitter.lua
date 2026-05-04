local M = {}

local uv = vim.uv or vim.loop
local EXTRA_ROOT = vim.fn.stdpath("config") .. "/treesitter"
local EXTRA_PARSER_DIR = EXTRA_ROOT .. "/parser"

local enabled_fts = {
  c = true,
  lua = true,
  markdown = true,
  query = true,
  vim = true,
  vimdoc = true,
  systemverilog = true,
  verilog = true,
  pss = true,
}

local function exists(path)
  return path and uv.fs_stat(path) ~= nil
end

local function add_rtp(path, prepend)
  if exists(path) and not vim.o.runtimepath:find(path, 1, true) then
    if prepend then
      vim.opt.runtimepath:prepend(path)
    else
      vim.opt.runtimepath:append(path)
    end
  end
end

local function parser_ext()
  if vim.fn.has("win32") == 1 then
    return "dll"
  elseif vim.fn.has("mac") == 1 then
    return "dylib"
  else
    return "so"
  end
end

local function ensure_lang(lang)
  if pcall(vim.treesitter.language.add, lang) then
    return true
  end

  if lang ~= "pss" and lang ~= "systemverilog" then
    vim.notify("treesitter parser not found for: " .. lang, vim.log.levels.ERROR, { title = "treesitter" })
    return false
  end

  local path = ("%s/%s.%s"):format(EXTRA_PARSER_DIR, lang, parser_ext())
  local ok, err = exists(path) and pcall(vim.treesitter.language.add, lang, { path = path })
  if ok then
    return true
  end

  vim.notify(
    ("failed to load parser %s from %s: %s"):format(lang, path, err or ""),
    vim.log.levels.ERROR,
    { title = "treesitter" }
  )
  return false
end

local function set_folds(buf)
  local win = vim.fn.bufwinid(buf)
  if win ~= -1 then
    vim.wo[win].foldmethod = "expr"
    vim.wo[win].foldexpr = "v:lua.vim.treesitter.foldexpr()"
  end
end

local function enable(buf)
  if not vim.api.nvim_buf_is_valid(buf) then
    return
  end

  local ft = vim.bo[buf].filetype
  if not enabled_fts[ft] then
    return
  end

  local lang = vim.treesitter.language.get_lang(ft)
  if not lang then
    return
  end

  if vim.b[buf].ts_core_started then
    set_folds(buf)
    return
  end

  if not ensure_lang(lang) then
    return
  end

  local ok, err = pcall(vim.treesitter.start, buf, lang)
  if not ok then
    local msg = tostring(err or "")
    if not (msg:match("already") or msg:match("attached") or msg:match("exists")) then
      vim.notify(
        ("failed to start treesitter for %s (%s): %s"):format(ft, lang, msg),
        vim.log.levels.ERROR,
        { title = "treesitter" }
      )
      return
    end
  end

  vim.b[buf].ts_core_started = true
  set_folds(buf)
end

function M.setup()
  add_rtp(EXTRA_ROOT, true)

  vim.treesitter.language.register("systemverilog", { "systemverilog", "verilog" })
  vim.treesitter.language.register("pss", { "pss" })

  local group = vim.api.nvim_create_augroup("UserTreeSitterCore", { clear = true })

  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = { "c", "lua", "markdown", "query", "vim", "vimdoc", "systemverilog", "verilog", "pss" },
    callback = function(ev)
      enable(ev.buf)
    end,
  })

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      enable(buf)
    end
  end

  vim.api.nvim_create_user_command("TSBufEnable", function(opts)
    enable(tonumber(opts.args) or vim.api.nvim_get_current_buf())
  end, { nargs = "?", desc = "Enable core treesitter for current buffer" })
end

return M
