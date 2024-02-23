return {
  "theprimeagen/refactoring.nvim",
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-treesitter/nvim-treesitter" },
  },
  keys = function()
    local refactoring = require("refactoring")
    local function refactor(s)
      return function() refactoring.refactor(s) end
    end
    return {
      { mode = "x",          "<leader>re",  refactor("Extract Function"),         desc = "[R]efactor [E]xtract Function" },
      { mode = "x",          "<leader>rf",  refactor("Extract Function To File"), desc = "[R]efactor Extract to [F]ile" },
      { mode = "x",          "<leader>rv",  refactor("Extract Variable"),         desc = "[R]efactor Extract [V]ariable" },
      { mode = "n",          "<leader>rI",  refactor("Inline Function"),          desc = "[R]efactor [I]nline Function" },
      { mode = { "n", "x" }, "<leader>ri",  refactor("Inline Variable"),          desc = "[R]efactor [I]nline Variable" },
      { mode = "n",          "<leader>rb",  refactor("Extract Block"),            desc = "[R]efactor Extract [B]lock" },
      { mode = "n",          "<leader>rbf", refactor("Extract Block To File"),    desc = "[R]efactor Extract [B]lock to [F]ile" },

      { mode = { "n", "x" }, "<leader>rr",  refactoring.select_refactor,          desc = "[R]efactor" },
    }
  end,
  opts = {},
}
