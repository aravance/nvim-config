local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions, { desc = '[G]oto [D]efinition' })
vim.keymap.set('n', '<leader>gD', builtin.lsp_type_definitions, { desc = '[G]oto [D]eclaration' })
vim.keymap.set('n', '<leader>gI', builtin.lsp_implementations, { desc = '[G]oto [I]mplementations' })
vim.keymap.set('n', '<leader>gr', builtin.lsp_references, { desc = '[G]oto [R]eferences' })
vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols, { desc = '[D]ocument [S]ymbols' })
vim.keymap.set('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols, { desc = '[W]orkspace [S]ymbols' })
vim.keymap.set('n', '<leader>ht', builtin.help_tags, { desc = '[H]elp [T]ags' })
vim.keymap.set('n', '<leader>hk', builtin.keymaps, { desc = '[H]elp [K]eymaps' })
vim.keymap.set('n', '<leader>pd', builtin.diagnostics, { desc = '[P]roject [D]iagnostics' })
vim.keymap.set('n', '<leader>pg', builtin.live_grep, { desc = '[P]roject [G]rep' })
vim.keymap.set('n', '<leader>pw', builtin.grep_string, { desc = 'Search [P]roject for current [W]ord' })
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = '[P]roject [F]iles' })
vim.keymap.set('n', '<leader>/', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzy search current buffer' })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Goto [P]roject git files' })
vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") });
end, { desc = '[P]roject Grep [S]earch' })
