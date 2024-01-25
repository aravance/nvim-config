require("aravance.remap")
require("aravance.packer")
require("aravance.set")

local MyGroup = vim.api.nvim_create_augroup('MyGroup', {})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = MyGroup,
  pattern = "*",
  command = [[%s/\s\+$//e]]
})

vim.g.netrw_banner = 0
