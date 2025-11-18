if jit.os == "OSX" then
  local lsp_vault_file = vim.fn.expand("~") .. "/vaults/work/lsp.lua"
  local stat = vim.uv.fs_stat(lsp_vault_file)
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
    {
      "folke/lazydev.nvim",
      event = "VeryLazy",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },

    -- LSP Support
    "stevearc/conform.nvim",
    { "j-hui/fidget.nvim",                 event = "VeryLazy", opts = {} },
    { "williamboman/mason.nvim",           event = "VeryLazy", opts = {} },
    { "williamboman/mason-lspconfig.nvim", event = "VeryLazy", opts = {} },
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      event = "VeryLazy",
      opts = {
        ensure_installed = {
          "ts_ls",
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

    ---@diagnostic disable-next-line: undefined-global
    if work_lsp_config then
      ---@diagnostic disable-next-line: undefined-global
      work_lsp_config()
    end
  end,
}
