return {
  "chrisgrieser/nvim-genghis",
  dependencies = {
    {
      "stevearc/dressing.nvim",
      opts = {},
      config = function()
        local cmp = require("cmp")
        cmp.setup.filetype("DressingInput", {
          sources = cmp.config.sources { { name = "omni" } }
        })
      end,
    },
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-omni",
  }
}