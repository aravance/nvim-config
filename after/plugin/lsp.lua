local lsp = require('lsp-zero')

-- setup neodev before lspconfig
-- this enables neovim lua config documentation and completion
require('neodev').setup {}

lsp.on_attach(function(_, bufnr)
  local map = function(mode, keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set(mode, keys, func, { buffer = bufnr, remap = false, desc = desc })
  end

  local telescope = require('telescope.builtin')

  map('n', '<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  map('n', '<leader>vd', vim.diagnostic.open_float, '[V]im [D]iagnostics')
  map({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  map({ 'n', 'x' }, '<leader>f', vim.lsp.buf.format, '[F]ormat file')
  map({ 'i', 'n' }, '<C-h>', vim.lsp.buf.signature_help, 'Signature [H]elp')
  map('n', 'gs', vim.lsp.buf.signature_help, '[S]ignature Help')
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

vim.filetype.add({ extension = { templ = 'templ' } })
lsp.configure('htmx', { filetypes = { 'html', 'templ' } })
lsp.configure('html', { filetypes = { 'html', 'templ' } })

-- add kotlin workspace detection
local lspconfig = require('lspconfig')
lsp.configure('kotlin_language_server', {
  workspaceFolders = true,
  root_dir = lspconfig.util.root_pattern(
    'packageInfo',
    { 'settings.gradle', 'settings.gradle.kts' },
    { 'build.gradle', 'build.gradle.kts' }
  ) or vim.fn.getcwd(),
})

require('mason').setup {}
require('mason-lspconfig').setup {
  handlers = {
    lsp.default_setup,
  },
  ensure_installed = {
    'tsserver',
    'eslint',
    'lua_ls',
    'kotlin_language_server',
    'gopls',
    'templ',
    'jdtls',
    'html',
    'htmx',
  },
}

-- load rafamadriz/friendl-snippets
require('luasnip.loaders.from_vscode').lazy_load()

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup {
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'luasnip', keyword_length = 2 },
    { name = 'buffer',  keyword_length = 3 },
  },
  formatting = lsp.cmp_format(),
  mapping = cmp.mapping.preset.insert {
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true, }),
    ['<C-Space>'] = cmp.mapping.complete(),
  },
}
