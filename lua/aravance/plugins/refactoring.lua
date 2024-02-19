return {
  "theprimeagen/refactoring.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-treesitter/nvim-treesitter" },
  },
  keys = function()
    local refactoring = require("refactoring")
  return {
    { "<leader>re",  mode = "x",          function() refactoring.refactor("Extract Function") end,         desc = "[R]efactor [E]xtract Function" },
    { "<leader>rf",  mode = "x",          function() refactoring.refactor("Extract Function To File") end, desc = "[R]efactor Extract to [F]ile" },
    { "<leader>rv",  mode = "x",          function() refactoring.refactor("Extract Variable") end,         desc = "[R]efactor Extract [V]ariable" },
    { "<leader>rI",  mode = "n",          function() refactoring.refactor("Inline Function") end,          desc = "[R]efactor [I]nline Function" },
    { "<leader>ri",  mode = { "n", "x" }, function() refactoring.refactor("Inline Variable") end,          desc = "[R]efactor [I]nline Variable" },
    { "<leader>rb",  mode = "n",          function() refactoring.refactor("Extract Block") end,            desc = "[R]efactor Extract [B]lock" },
    { "<leader>rbf", mode = "n",          function() refactoring.refactor("Extract Block To File") end,    desc = "[R]efactor Extract [B]lock to [F]ile" },

    ---@diagnostic disable-next-line: missing-parameter
    { "<leader>rr",  mode = { "n", "x" }, function() refactoring.select_refactor() end,                    desc = "[R]efactor" },
  }
  end,
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("refactoring").setup {}
  end,
}
