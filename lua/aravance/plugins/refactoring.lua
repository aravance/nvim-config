return {
  'theprimeagen/refactoring.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-treesitter/nvim-treesitter' },
  },
  config = function()
    local refactoring = require('refactoring')
    ---@diagnostic disable-next-line: missing-fields
    refactoring.setup {}

    local function refactor(s)
      return function()
        refactoring.refactor(s)
      end
    end

    keymap("x", "<leader>re", refactor('Extract Function'), "[R]efactor [E]xtract Function")
    keymap("x", "<leader>rf", refactor('Extract Function To File'), "[R]efactor Extract to [F]ile")
    keymap("x", "<leader>rv", refactor('Extract Variable'), "[R]efactor Extract [V]ariable")
    keymap("n", "<leader>rI", refactor('Inline Function'), "[R]efactor [I]nline Function")
    keymap({ "n", "x" }, "<leader>ri", refactor('Inline Variable'), "[R]efactor [I]nline Variable")

    keymap("n", "<leader>rb", refactor('Extract Block'), "[R]efactor Extract [B]lock")
    keymap("n", "<leader>rbf", refactor('Extract Block To File'), "[R]efactor Extract [B]lock to [F]ile")

    ---@diagnostic disable-next-line: missing-parameter
    keymap({ "n", "x" }, "<leader>rr", function() refactoring.select_refactor() end, "[R]efactor")
  end,
}
