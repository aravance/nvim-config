local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    'tsserver',
    'eslint',
    'lua_ls',
    'kotlin_language_server',
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp( {
    mapping = cmp_mappings
})

lsp.on_attach(function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, remap = false, desc = desc })
    end

    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, { buffer = bufnr, remap = false, desc = 'Signature [H]elp' })
    nmap("<C-h>", vim.lsp.buf.signature_help, 'Signature [H]elp')
    nmap("gd", vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap("gI", vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap("gr", vim.lsp.buf.references, '[G]oto [R]eferences')
    nmap("K", vim.lsp.buf.hover, 'Hover Documentation')
    nmap("<leader>ca", vim.lsp.buf.code_action, '[C]ode [A]ction')
    nmap("<leader>rn", vim.lsp.buf.rename, '[R]e[n]ame')
    nmap("<leader>vd", vim.diagnostic.open_float, '[V]im [D]iagnostics')
    nmap("]d", vim.diagnostic.goto_next, 'Next [D]iagnostic')
    nmap("[d", vim.diagnostic.goto_prev, 'Previous [D]iagnostic')
end)

lsp.configure('kotlin_language_server', {
    workspaceFolders = true,
    root_dir = require 'lspconfig'.util.root_pattern("packageInfo", vim.fn.getcwd()),
})

lsp.nvim_workspace()
lsp.setup()
