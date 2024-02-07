local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'lua_ls',
  'kotlin_language_server',
  'gopls',
  'templ',
  'jdtls',
  'html',
  'htmx',
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({
    behavior = cmp.ConfirmBehavior.Insert,
    select = true,
  }),
  ['<C-Space>'] = cmp.mapping.complete {},
  ['<CR>'] = cmp.mapping.confirm {
    behavior = cmp.ConfirmBehavior.Replace,
    select = true,
  },
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.on_attach(function(_, bufnr)
  local map = function(mode, keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set(mode, keys, func, { buffer = bufnr, remap = false, desc = desc })
  end

  map({ "i", "n" }, "<C-h>", vim.lsp.buf.signature_help, 'Signature [H]elp')
  map("n", "gd", vim.lsp.buf.definition, '[G]oto [D]efinition')
  map("n", "gD", vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  map("n", "gI", vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  map("n", "gr", vim.lsp.buf.references, '[G]oto [R]eferences')
  map("n", "K", vim.lsp.buf.hover, 'Hover Documentation')
  map({ "n", "x" }, "<leader>f", vim.lsp.buf.format, "[F]ormat file")
  map("n", "<leader>ca", vim.lsp.buf.code_action, '[C]ode [A]ction')
  map("n", "<leader>rn", vim.lsp.buf.rename, '[R]e[n]ame')
  map("n", "<leader>vd", vim.diagnostic.open_float, '[V]im [D]iagnostics')
  map("n", "]d", vim.diagnostic.goto_next, 'Next [D]iagnostic')
  map("n", "[d", vim.diagnostic.goto_prev, 'Previous [D]iagnostic')
end)

lsp.format_on_save {
  format_opts = {
    async = false,
    timeout_ms = 5000,
  },
  servers = {
    ['lua_ls'] = { 'lua' },
    ['templ'] = { 'templ' },
  }
}

vim.filetype.add({ extension = { templ = "templ" } })
lsp.configure('htmx', { filetypes = { "html", "templ" } })
lsp.configure('html', { filetypes = { "html", "templ" } })

-- setup neodev before lspconfig
require('neodev').setup {}

local lspconfig = require('lspconfig')
lsp.configure('kotlin_language_server', {
  workspaceFolders = true,
  root_dir = lspconfig.util.root_pattern(
    "packageInfo",
    { "settings.gradle", "settings.gradle.kts" },
    { "build.gradle", "build.gradle.kts" }
  ) or vim.fn.getcwd(),
})

lsp.nvim_workspace()
lsp.setup()
