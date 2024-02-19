return {
  'VonHeikemen/lsp-zero.nvim',
  dependencies = {
    -- LSP Support
    { 'neovim/nvim-lspconfig' },             -- Required
    { 'williamboman/mason.nvim' },           -- Optional
    { 'williamboman/mason-lspconfig.nvim' }, -- Optional
    { 'mhartington/formatter.nvim' },        -- Optional

    -- Autocompletion
    { 'hrsh7th/nvim-cmp' },         -- Required
    { 'hrsh7th/cmp-nvim-lsp' },     -- Required
    { 'hrsh7th/cmp-buffer' },       -- Optional
    { 'hrsh7th/cmp-path' },         -- Optional
    { 'saadparwaiz1/cmp_luasnip' }, -- Optional
    { 'hrsh7th/cmp-nvim-lua' },     -- Optional

    -- Snippets
    { 'L3MON4D3/LuaSnip' },             -- Required
    { 'rafamadriz/friendly-snippets' }, -- Optional

    -- Neovim lua support
    { 'folke/neodev.nvim' },
    { 'j-hui/fidget.nvim' },
  },
  config = function()
    local lsp = require('lsp-zero')

    -- setup neodev before lspconfig
    -- this enables neovim lua config documentation and completion
    require('neodev').setup {}

    lsp.set_sign_icons {
      error = '✘',
      warn = '▲',
      hint = '⚑',
      info = '»',
    }

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

    require('fidget').setup {}
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

    -- load rafamadriz/friendly-snippets
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
  end,
}
