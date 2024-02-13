function keymap(s, a, f, o)
  local opts = {}
  if type(o) == 'string' then
    opts.desc = o
  end
  if type(o) == "table" then
    opts = o
  end
  vim.keymap.set(s, a, f, opts)
end

require("aravance.remap")
require("aravance.lazy")
require("aravance.set")

vim.g.netrw_banner = 0
