local systemverilog_extensions = {
  "v",
  "vh",
  "vp",
  "sv",
  "svi",
  "svh",
  "svp",
  "sva",
}

local extension = {
  pss = "pss",
}

for _, ext in ipairs(systemverilog_extensions) do
  extension[ext] = "systemverilog"
end

vim.filetype.add({
  extension = extension,
})
