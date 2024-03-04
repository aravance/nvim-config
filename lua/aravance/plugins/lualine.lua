return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  init = function()
    vim.opt.showmode = false
  end,
  opts = {
    options = {
      component_separators = "|",
      section_separators = "",
    }
  },
}
