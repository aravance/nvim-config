return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Neovim lua support
    -- do this first to make sure it's setup before the lsp
    {
      "folke/neodev.nvim", -- Optional
      opts = {},
    },

    -- LSP Support
    {
      "williamboman/mason.nvim", -- Optional
      opts = {},
    },
    {
      "williamboman/mason-lspconfig.nvim", -- Optional
      opts = {
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup {
              capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                require("cmp_nvim_lsp").default_capabilities()
              )
            }
          end,
        },
      },
    },
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim", -- Optional
      opts = {
        ensure_installed = {
          "tsserver",
          "eslint",
          "lua_ls",
          "kotlin_language_server",
          "ktlint",
          "gopls",
          "goimports",
          "templ",
          "jdtls",
          "html",
          "htmx",
        },
      },
    },
    { "stevearc/conform.nvim" }, -- Optional
    {
      "j-hui/fidget.nvim",       -- Optional
      opts = {},
    },

    -- Autocompletion
    {
      "hrsh7th/nvim-cmp", -- Required
      opts = {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end
        },
        sources = {
          { name = "path" },
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "luasnip", keyword_length = 2 },
          { name = "buffer",  keyword_length = 3 },
        },
        mapping = require("cmp").mapping.preset.insert {
          ["<C-p>"] = require("cmp").mapping.select_prev_item({ behavior = require("cmp").SelectBehavior.Select }),
          ["<C-n>"] = require("cmp").mapping.select_next_item({ behavior = require("cmp").SelectBehavior.Select }),
          ["<C-y>"] = require("cmp").mapping.confirm({ select = true, }),
          ["<C-Space>"] = require("cmp").mapping.complete(),
        },
      },
    },
    { "hrsh7th/cmp-nvim-lsp" },     -- Required
    { "hrsh7th/cmp-buffer" },       -- Optional
    { "hrsh7th/cmp-path" },         -- Optional
    { "saadparwaiz1/cmp_luasnip" }, -- Optional
    { "hrsh7th/cmp-nvim-lua" },     -- Optional

    -- Snippets
    { "L3MON4D3/LuaSnip" }, -- Required

  },
  config = function()
    vim.filetype.add({ extension = { templ = "templ" } })

    -- add kotlin workspace detection
    local lspconfig = require("lspconfig")
    lspconfig.kotlin_language_server.setup {
      workspaceFolders = true,
      root_dir = lspconfig.util.root_pattern(
        "packageInfo",
        { "settings.gradle", "settings.gradle.kts" },
        { "build.gradle", "build.gradle.kts" }
      ) or vim.fn.getcwd(),
    }
  end,
}