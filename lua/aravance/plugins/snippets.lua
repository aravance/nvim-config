return {
  "L3MON4D3/LuaSnip",
  event = "VeryLazy",
  dependencies = { "rafamadriz/friendly-snippets" }, -- Optional
  keys = {
    { mode = "i",          "<C-K>", function() require("luasnip")() end,   desc = "Expand snippet" },
    { mode = { "i", "s" }, "<C-L>", function() require("luasnip")(1) end,  desc = "Next snippet var" },
    { mode = { "i", "s" }, "<C-J>", function() require("luasnip")(-1) end, desc = "Previous snippet var" },
  },
  config = function()
    -- load rafamadriz/friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}
