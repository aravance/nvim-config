return {
  "tpope/vim-sleuth",
  { "echasnovski/mini.ai",        opts = {} },
  { "echasnovski/mini.bracketed", opts = {} },
  { "echasnovski/mini.comment",   opts = {} },
  {
    "echasnovski/mini.surround",
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
