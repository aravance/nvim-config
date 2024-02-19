return {
  "mhartington/formatter.nvim",
  config = function()
    require("formatter").setup {
      filetype = {
        go = {
          require("formatter.filetypes.go").goimports,
        },
        kotlin = {
          require("formatter.filetypes.kotlin").ktlint,
        },
        lua = {
          vim.lsp.buf.format,
        },
        templ = {
          function()
            vim.cmd [[silent %!templ fmt]]
          end,
        },
        ["*"] = {
          require("formatter.filetypes.any").remove_trailing_whitespace
        },
      }
    }

    vim.api.nvim_create_augroup("__formatter__", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = "__formatter__",
      command = ":FormatWrite",
    })
  end,
}
