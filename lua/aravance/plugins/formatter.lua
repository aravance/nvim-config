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

    local lsp_format_enabled = {
      lua = true,
    }

    local formatter_grp = vim.api.nvim_create_augroup("__formatter__", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = formatter_grp,
      command = ":FormatWrite",
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
      group = formatter_grp,
      callback = function()
        if lsp_format_enabled[vim.bo.filetype] then
          vim.lsp.buf.format { async = false }
        end
      end,
    })
  end,
}
