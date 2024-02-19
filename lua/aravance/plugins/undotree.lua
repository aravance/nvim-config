return {
  'mbbill/undotree',
  config = function()
    keymap("n", "<leader>u", vim.cmd.UndotreeToggle, "Open [U]ndotree")
  end,
}
