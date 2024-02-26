if vim.loop.os_uname().sysname == "Darwin" then
  local lsp_vault_file = vim.fn.expand("~") .. "/vaults/work/lsp.lua"
  local stat = vim.loop.fs_stat(lsp_vault_file)
  if stat and stat.type == "file" then
    dofile(lsp_vault_file)
  end
end

return {
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  dependencies = {
    -- Neovim lua support
    -- do this first to make sure it's setup before the lsp
    { "folke/neodev.nvim",       event = "VeryLazy", opts = {} },

    -- LSP Support
    "stevearc/conform.nvim",
    { "j-hui/fidget.nvim",       event = "VeryLazy", opts = {} },
    { "williamboman/mason.nvim", event = "VeryLazy", opts = {} },
    {
      "williamboman/mason-lspconfig.nvim",
      event = "VeryLazy",
      opts = {
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup {
              on_attach = function()
                if work_lsp_on_attach then
                  work_lsp_on_attach()
                end
              end,
              capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                require("cmp_nvim_lsp").default_capabilities()
              ),
            }
          end,
        },
      },
    },
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      event = "VeryLazy",
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

    -- Autocompletion
    {
      "hrsh7th/nvim-cmp",
      event = "VeryLazy",
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
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lua",

    -- Snippets
    "L3MON4D3/LuaSnip",

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
