local refactoring = require('refactoring')
refactoring.setup {}

local function refactor(s)
  return function()
    refactoring.refactor(s)
  end
end

vim.keymap.set("x", "<leader>re", refactor('Extract Function'), { desc = "[R]efactor [E]xtract Function" })
vim.keymap.set("x", "<leader>rf", refactor('Extract Function To File'), { desc = "[R]efactor Extract to [F]ile" })
vim.keymap.set("x", "<leader>rv", refactor('Extract Variable'), { desc = "[R]efactor Extract [V]ariable" })
vim.keymap.set("n", "<leader>rI", refactor('Inline Function'), { desc = "[R]efactor [I]nline Function" })
vim.keymap.set({ "n", "x" }, "<leader>ri", refactor('Inline Variable'), { desc = "[R]efactor [I]nline Variable" })

vim.keymap.set("n", "<leader>rb", refactor('Extract Block'), { desc = "[R]efactor Extract [B]lock" })
vim.keymap.set("n", "<leader>rbf", refactor('Extract Block To File'), { desc = "[R]efactor Extract [B]lock to [F]ile" })

vim.keymap.set({ "n", "x" }, "<leader>rr", function() refactoring.select_refactor() end, { desc = "[R]efactor" })
