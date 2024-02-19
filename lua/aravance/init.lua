--- Set up a mapped key binding
--- @param m string|table the mode(s) to bind
--- @param l string the keys to bind
--- @param r string|function the action to perform
--- @param o string|table|nil the description or options to use to bind the mapping
function keymap(m, l, r, o)
  local opts = {}
  if type(o) == 'string' then
    opts.desc = o
  end
  if type(o) == "table" then
    opts = o
  end
  vim.keymap.set(m, l, r, opts)
end

require("aravance.remap")
require("aravance.set")
require("aravance.lazy")

vim.g.netrw_banner = 0

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(e)
    local map = function(mode, keys, func, desc)
      if desc then
        desc = 'LSP: ' .. desc
      end
      vim.keymap.set(mode, keys, func, { buffer = e.buf, remap = false, desc = desc })
    end

    local telescope = require('telescope.builtin')

    map('n', '<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('n', '<leader>vd', vim.diagnostic.open_float, '[V]im [D]iagnostics')
    map({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    map({ 'n', 'x' }, '<leader>f', vim.lsp.buf.format, '[F]ormat file')
    map({ 'i', 'n' }, '<C-h>', vim.lsp.buf.signature_help, 'Signature [H]elp')
    map('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    map('n', 'gd', telescope.lsp_definitions, '[G]oto [D]efinition')
    map('n', 'gy', telescope.lsp_type_definitions, '[G]oto T[y]pe Definition')
    map('n', 'gi', telescope.lsp_implementations, '[G]oto [I]mplementation')
    map('n', 'gr', telescope.lsp_references, '[G]oto [R]eferences')
    map('n', '<leader>ds', telescope.lsp_document_symbols, '[D]ocument [S]ymbols')
    map('n', '<leader>ws', telescope.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    map('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
    map('n', ']d', vim.diagnostic.goto_next, 'Next [D]iagnostic')
    map('n', '[d', vim.diagnostic.goto_prev, 'Previous [D]iagnostic')
  end
})
