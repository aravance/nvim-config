require("aravance.remap")
require("aravance.set")
require("aravance.lazy")

vim.g.netrw_banner = 0

local lsp_commands = vim.api.nvim_create_augroup("lsp_commands", {})

vim.api.nvim_create_autocmd("LspAttach", {
  group = lsp_commands,
  callback = function(e)
    local map = function(mode, keys, func, desc)
      if desc then
        desc = "LSP: " .. desc
      end
      vim.keymap.set(mode, keys, func, { buffer = e.buf, remap = false, desc = desc })
    end

    map("n", "<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    map("n", "<leader>vd", vim.diagnostic.open_float, "[V]im [D]iagnostics")
    map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    map({ "i", "n" }, "<C-h>", vim.lsp.buf.signature_help, "Signature [H]elp")
    map("n", "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    map("n", "gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    map("n", "gy", vim.lsp.buf.type_definition, "[G]oto T[y]pe Definition")
    map("n", "gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    map("n", "gr", vim.lsp.buf.references, "[G]oto [R]eferences")
    map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
  end,
})
