return {
  "theprimeagen/harpoon",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>m", function() require("harpoon.mark").add_file() end,        desc = "Harpoon [M]ark file" },
    { "<C-g>",     function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon Menu" },
    { "<C-j>",     function() require("harpoon.ui").nav_file(1) end,         desc = "Harpoon file 1" },
    { "<C-k>",     function() require("harpoon.ui").nav_file(2) end,         desc = "Harpoon file 2" },
    { "<C-l>",     function() require("harpoon.ui").nav_file(3) end,         desc = "Harpoon file 3" },
    { "<C-'>",     function() require("harpoon.ui").nav_file(4) end,         desc = "Harpoon file 4" },
  },
}
