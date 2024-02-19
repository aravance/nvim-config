return {
  "nvim-telescope/telescope.nvim",
  version = "0.1.x",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = function()
    local builtin = require("telescope.builtin")
    local find_hidden_files = function()
      builtin.find_files { hidden = true, file_ignore_patterns = { ".git/" } }
    end
    local search_current_buffer = function()
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown { previewer = false, })
    end
    return {
      { "<leader>ht", builtin.help_tags,     desc = "[H]elp [T]ags" },
      { "<leader>hk", builtin.keymaps,       desc = "[H]elp [K]eymaps" },
      { "<leader>pd", builtin.diagnostics,   desc = "[P]roject [D]iagnostics" },
      { "<leader>pg", builtin.live_grep,     desc = "[P]roject [G]rep" },
      { "<leader>pw", builtin.grep_string,   desc = "Search [P]roject for current [W]ord" },
      { "<leader>pf", builtin.find_files,    desc = "[P]roject [F]iles" },
      { "<leader>ph", find_hidden_files,     desc = "[P]roject Files (+[h]idden)" },
      { "<leader>/",  search_current_buffer, desc = "Fuzzy search current buffer" },
      { "<C-p>",      builtin.git_files,     desc = "Goto [P]roject git files" },
    }
  end,
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup {
      defaults = {
        mappings = {
          i = {
            ["<C-y>"] = actions.select_default,
            ["<C-h>"] = actions.which_key,
          },
          n = {
            ["<C-y>"] = actions.select_default,
          },
        },
      },
    }
  end,
}
