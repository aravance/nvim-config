return {
  "theprimeagen/harpoon",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<C-g>",     function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon Menu" },
    { "<leader>m", function() require("harpoon.mark").add_file() end,        desc = "Harpoon [M]ark file" },
    { "<leader>1", function() require("harpoon.ui").nav_file(1) end,         desc = "Harpoon file 1" },
    { "<leader>2", function() require("harpoon.ui").nav_file(2) end,         desc = "Harpoon file 2" },
    { "<leader>3", function() require("harpoon.ui").nav_file(3) end,         desc = "Harpoon file 3" },
    { "<leader>4", function() require("harpoon.ui").nav_file(4) end,         desc = "Harpoon file 4" },
    { "<leader>5", function() require("harpoon.ui").nav_file(5) end,         desc = "Harpoon file 5" },
  },
}
