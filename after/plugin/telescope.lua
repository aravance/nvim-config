local telescope = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-y>'] = actions.select_default,
        ['<C-h>'] = actions.which_key,
      },
      n = {
        ['<C-y>'] = actions.select_default,
      },
    },
  },
}

keymap('n', '<leader>gd', builtin.lsp_definitions, '[G]oto [D]efinition')
keymap('n', '<leader>gD', builtin.lsp_type_definitions, '[G]oto [D]eclaration')
keymap('n', '<leader>gI', builtin.lsp_implementations, '[G]oto [I]mplementations')
keymap('n', '<leader>gr', builtin.lsp_references, '[G]oto [R]eferences')
keymap('n', '<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
keymap('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
keymap('n', '<leader>ht', builtin.help_tags, '[H]elp [T]ags')
keymap('n', '<leader>hk', builtin.keymaps, '[H]elp [K]eymaps')
keymap('n', '<leader>pd', builtin.diagnostics, '[P]roject [D]iagnostics')
keymap('n', '<leader>pg', builtin.live_grep, '[P]roject [G]rep')
keymap('n', '<leader>pw', builtin.grep_string, 'Search [P]roject for current [W]ord')
keymap('n', '<leader>pf', builtin.find_files, '[P]roject [F]iles')
keymap('n', '<leader>/', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    previewer = false,
  })
end, 'Fuzzy search current buffer')
keymap('n', '<C-p>', builtin.git_files, 'Goto [P]roject git files')
