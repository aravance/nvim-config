function ColorMyPencils(color)
  color = color or 'moonfly'
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
  'bluz71/vim-moonfly-colors',
  name = 'moonfly',
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.moonflyTransparent = true
    vim.cmd [[colorscheme moonfly]]
    ColorMyPencils()
  end
}
