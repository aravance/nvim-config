return {
  "nvim-telescope/telescope.nvim",
  version = "0.1.x",
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim",       event = "VeryLazy" }, -- Required
    { "nvim-tree/nvim-web-devicons", event = "VeryLazy" }, -- Optional
  },
  keys = function()
    local builtin = require("telescope.builtin")
    local themes = require("telescope.themes")

    local function find_hidden_files()
      builtin.find_files { hidden = true, file_ignore_patterns = { ".git/" } }
    end
    local function search_current_buffer()
      builtin.current_buffer_fuzzy_find(themes.get_dropdown { previewer = false, })
    end
    local function spell_suggest()
      builtin.spell_suggest(themes.get_cursor())
    end

    return {
      { "<leader>gd", builtin.lsp_definitions,               desc = "[G]oto [D]efinition" },
      { "<leader>gy", builtin.lsp_type_definitions,          desc = "[G]oto T[y]pe Definition" },
      { "<leader>gi", builtin.lsp_implementations,           desc = "[G]oto [I]mplementation" },
      { "<leader>gr", builtin.lsp_references,                desc = "[G]oto [R]eferences" },
      { "<leader>ds", builtin.lsp_document_symbols,          desc = "[D]ocument [S]ymbols" },
      { "<leader>ws", builtin.lsp_dynamic_workspace_symbols, desc = "[W]orkspace [S]ymbols" },
      { "<leader>ht", builtin.help_tags,                     desc = "[H]elp [t]ags" },
      { "<leader>hk", builtin.keymaps,                       desc = "[H]elp [k]eymaps" },
      { "<leader>pd", builtin.diagnostics,                   desc = "[P]roject [d]iagnostics" },
      { "<leader>pf", builtin.find_files,                    desc = "[P]roject [f]iles" },
      { "<leader>ph", find_hidden_files,                     desc = "[P]roject files (+[h]idden)" },
      { "<leader>/",  search_current_buffer,                 desc = "Fuzzy search current buffer" },
      { "z=",         spell_suggest,                         desc = "Spelling suggestions" },
      { "<C-p>",      builtin.git_files,                     desc = "Goto [p]roject git files" },
      { "<leader>pg", builtin.live_grep,                     desc = "[P]roject live [g]rep" },
      {
        "<leader>pw",
        function()
          builtin.grep_string { search = vim.fn.expand("<cword>") }
        end,
        desc = "[P]roject search for current [w]ord"
      },
      {
        "<leader>pW",
        function()
          builtin.grep_string { search = vim.fn.expand("<cWORD>") }
        end,
        desc = "[P]roject search for current [W]ORD"
      },
      {
        "<leader>ps",
        function()
          builtin.grep_string { search = vim.fn.input("Grep > ") }
        end,
        desc = "[P]roject search for input word"
      },
    }
  end,
  opts = {
    defaults = {
      path_display = {
        "filename_first",
      }
      mappings = {
        i = {
          ["<C-y>"] = require("telescope.actions").select_default,
          ["<C-h>"] = require("telescope.actions").which_key,
        },
        n = {
          ["<C-y>"] = require("telescope.actions").select_default,
        },
      },
    },
  },
}
