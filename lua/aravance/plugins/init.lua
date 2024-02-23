return {
  { "tpope/vim-sleuth",           event = "VeryLazy" },
  { "echasnovski/mini.ai",        event = "VeryLazy", opts = {} },
  { "echasnovski/mini.bracketed", event = "VeryLazy", opts = {} },
  { "echasnovski/mini.comment",   event = "VeryLazy", opts = {} },
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    opts = {
      mappings = {
        add = "ys",
        delete = "ds",
        find = "",
        find_left = "",
        highlight = "",
        replace = "cs",
        update_n_lines = "",
      },
    },
  },
}
