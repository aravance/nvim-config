return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  keys = {
    { mode = { "n", "x" }, "<leader>f", function() require("conform").format({ lsp_fallback = true }) end, desc = "[F]ormat file" },
  },
  opts = {
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      kotlin = { "ktlint" },
      go = { "goimports" },
      templ = { "templ" },
    },
  },
}
