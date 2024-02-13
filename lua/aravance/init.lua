--- Set up a mapped key binding
--- @param m string|table the mode(s) to bind
--- @param l string the keys to bind
--- @param r string|function the action to perform
--- @param o string|table|nil the description or options to use to bind the mapping
function keymap(m, l, r, o)
  local opts = {}
  if type(o) == 'string' then
    opts.desc = o
  end
  if type(o) == "table" then
    opts = o
  end
  vim.keymap.set(m, l, r, opts)
end

require("aravance.remap")
require("aravance.lazy")
require("aravance.set")

vim.g.netrw_banner = 0
