return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- LSP Support
    { 'williamboman/mason.nvim' },           -- Optional
    { 'williamboman/mason-lspconfig.nvim' }, -- Optional
    { 'mhartington/formatter.nvim' },        -- Optional
    { 'j-hui/fidget.nvim' },                 -- Optional

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
  },
  config = function()
    -- setup neodev before lspconfig
    -- this enables neovim lua config documentation and completion
    require('neodev').setup {}

    vim.filetype.add({ extension = { templ = 'templ' } })

    -- add kotlin workspace detection
    local lspconfig = require('lspconfig')
    lspconfig.kotlin_language_server.setup {
      workspaceFolders = true,
      root_dir = lspconfig.util.root_pattern(
        'packageInfo',
        { 'settings.gradle', 'settings.gradle.kts' },
        { 'build.gradle', 'build.gradle.kts' }
      ) or vim.fn.getcwd(),
    }

    local cmp = require('cmp')
    local cmp_lsp = require('cmp_nvim_lsp')
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )

    require('fidget').setup {}
    require('mason').setup {}
    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          lspconfig[server_name].setup {
            capabilities = capabilities,
          }
        end,
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

    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    cmp.setup {
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end
      },
      sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip', keyword_length = 2 },
        { name = 'buffer',  keyword_length = 3 },
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true, }),
        ['<C-Space>'] = cmp.mapping.complete(),
      },
    }
  end,
}
