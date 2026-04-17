return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    local treesitter = require("nvim-treesitter")
    local filetypes = {
      "vimdoc",
      "vim",
      "bash",
      "javascript",
      "typescript",
      "c",
      "cpp",
      "lua",
      "luadoc",
      "markdown",
      "markdown_inline",
      "kotlin",
      "java",
      "go",
      "html",
      "toml",
      "yaml",
      "gitignore",
    }
    treesitter.setup()
    treesitter.install(filetypes)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = filetypes,
      callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
