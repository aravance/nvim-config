return {
  'nvim-telescope/telescope.nvim',
  version = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
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

    keymap('n', '<leader>ht', builtin.help_tags, '[H]elp [T]ags')
    keymap('n', '<leader>hk', builtin.keymaps, '[H]elp [K]eymaps')
    keymap('n', '<leader>pd', builtin.diagnostics, '[P]roject [D]iagnostics')
    keymap('n', '<leader>pg', builtin.live_grep, '[P]roject [G]rep')
    keymap('n', '<leader>pw', builtin.grep_string, 'Search [P]roject for current [W]ord')
    keymap('n', '<leader>pf', builtin.find_files, '[P]roject [F]iles')
    keymap('n', '<leader>ph', function()
      builtin.find_files { hidden = true, file_ignore_patterns = { ".git/" } }
    end, '[P]roject Files (+[h]idden)')
    keymap('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        previewer = false,
      })
    end, 'Fuzzy search current buffer')
    keymap('n', '<C-p>', builtin.git_files, 'Goto [P]roject git files')
  end,
}
