local M = {}

local function get_username()
  local user = os.getenv("USER") or os.getenv("USERNAME")
  if user and user ~= "" then
    return user
  end

  local ok, out = pcall(vim.fn.systemlist, "whoami")
  if ok and out and out[1] and out[1] ~= "" then
    return out[1]
  end

  return ""
end

local function snippet_vars()
  return {
    TM_FILENAME_BASE = vim.fn.expand("%:t:r"),
    MY_FILE_TYPE = vim.fn.expand("%:e"),
    MY_USER_NAME = get_username(),
    CURRENT_YEAR = os.date("%Y"),
    CURRENT_MONTH_NAME = os.date("%B"),
    CURRENT_DATE = os.date("%d"),
  }
end

local function render_vars(text)
  local vars = snippet_vars()
  return (text:gsub("%${([A-Z_]+)}", function(name)
    return vars[name] or ""
  end))
end

local snippets = {
  systemverilog = {
    ["function"] = [=[
//--------------------------------------------------------------------------------
function ${1:void} ${2:class_name}::${3:function_name}(${4});
	$0
endfunction : $3
]=],

    ["task"] = [=[
//--------------------------------------------------------------------------------
task ${1:class_name}::${2:task_name}(${3});
	$0
endtask : $2
]=],

    uvmobj = [=[
class ${1:uvm_class} extends ${2:uvm_object};
	$0

	`uvm_object_utils_begin($1)
	`uvm_object_utils_end

	extern function new(string name="$1");

endclass : $1

//--------------------------------------------------------------------------------
function $1::new(string name="$1");
	super.new(name);
endfunction : new
]=],

    uvmcom = [=[
class ${1:uvm_class} extends ${2:uvm_component};
	$0

	`uvm_component_utils_begin($1)
	`uvm_component_utils_end

	extern function new(string name="$1", uvm_component parent=null);

endclass : $1

//--------------------------------------------------------------------------------
function $1::new(string name="$1", uvm_component parent=null);
	super.new(name, parent);
endfunction : new
]=],

    head = [=[
// =============================================================================
// COPYRIGHT (C) 2024 SiEngine Inc.
//
// Component Name   : AD1000
// Component Version: 1.00a
// Release Type     : Internal
//
// Author           : ${MY_USER_NAME}
// Created Date     : ${CURRENT_YEAR}-${CURRENT_MONTH_NAME}-${CURRENT_DATE}
//
// -----------------------------------------------------------------------------

`ifndef __${TM_FILENAME_BASE}__${MY_FILE_TYPE}__
`define __${TM_FILENAME_BASE}__${MY_FILE_TYPE}__

$0

`endif // __${TM_FILENAME_BASE}__${MY_FILE_TYPE}__
]=],
  },
}

local function get_snippet(ft, trigger)
  local ft_snips = snippets[ft]
  if not ft_snips then
    return nil
  end
  return ft_snips[trigger]
end

local function current_trigger()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  local before = line:sub(1, col)
  local trigger = before:match("([%w_]+)$")
  return row, col, trigger
end

local function feed(keys)
  vim.api.nvim_feedkeys(vim.keycode(keys), "n", false)
end

function M.expand(name)
  local ft = vim.bo.filetype
  local body = get_snippet(ft, name)
  if not body then
    vim.notify(
      ("snippet not found: %s (%s)"):format(name, ft),
      vim.log.levels.WARN,
      { title = "snippets" }
    )
    return
  end

  vim.snippet.expand(render_vars(body))
end

function M.expand_or_jump()
  if vim.snippet.active({ direction = 1 }) then
    vim.snippet.jump(1)
    return true
  end

  local buf = vim.api.nvim_get_current_buf()
  local win = vim.api.nvim_get_current_win()
  local ft = vim.bo[buf].filetype
  local row, col, trigger = current_trigger()

  if not trigger then
    return false
  end

  local body = get_snippet(ft, trigger)
  if not body then
    return false
  end

  local expanded = render_vars(body)
  local trigger_len = #trigger

  vim.schedule(function()
    if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_win_is_valid(win) then
      return
    end

    if vim.api.nvim_get_current_buf() ~= buf then
      return
    end

    local start_col = col - trigger_len
    if start_col < 0 then
      return
    end

    vim.api.nvim_buf_set_text(buf, row - 1, start_col, row - 1, col, { "" })
    vim.api.nvim_win_set_cursor(win, { row, start_col })
    vim.snippet.expand(expanded)
  end)

  return true
end

function M.jump_prev()
  if vim.snippet.active({ direction = -1 }) then
    vim.snippet.jump(-1)
    return true
  end
  return false
end

function M.setup()
  vim.keymap.set("i", "<Tab>", function()
    if M.expand_or_jump() then
      return
    end
    feed("<Tab>")
  end, { desc = "Expand snippet or jump forward", silent = true })

  vim.keymap.set("s", "<Tab>", function()
    if M.expand_or_jump() then
      return
    end
    feed("<Tab>")
  end, { desc = "Expand snippet or jump forward", silent = true })

  vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
    if M.jump_prev() then
      return
    end
    feed("<S-Tab>")
  end, { desc = "Jump to previous snippet placeholder", silent = true })

  vim.api.nvim_create_user_command("Snip", function(opts)
    M.expand(opts.args)
  end, {
    nargs = 1,
    desc = "Expand built-in snippet",
    complete = function()
      local ft = vim.bo.filetype
      return vim.tbl_keys(snippets[ft] or {})
    end,
  })
end

return M
