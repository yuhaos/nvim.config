local M = {}

local uv = vim.uv or vim.loop

local function normalize_path(path)
  if not path or path == "" then
    return uv.cwd()
  end

  path = vim.fn.expand(path)
  if vim.fn.isdirectory(path) == 1 then
    return vim.fn.fnamemodify(path, ":p")
  end

  return vim.fn.fnamemodify(path, ":p:h")
end

function M.project_root(path)
  local start = normalize_path(path or vim.api.nvim_buf_get_name(0))
  local git_dir = vim.fs.find(".git", { path = start, upward = true, type = "directory" })[1]
  if git_dir then
    return vim.fs.dirname(git_dir)
  end
  return start
end

function M.buffer_dir()
  local name = vim.api.nvim_buf_get_name(0)
  if name == "" then
    return uv.cwd()
  end
  return normalize_path(name)
end

return M
