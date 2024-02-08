local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

keymap("n", "<leader>m", mark.add_file, "Harpoon [A]dd File")
keymap("n", "<C-g>", ui.toggle_quick_menu, "Harpoon Menu")

keymap("n", "<C-j>", function() ui.nav_file(1) end, "Harpoon file 1")
keymap("n", "<C-k>", function() ui.nav_file(2) end, "Harpoon file 2")
keymap("n", "<C-l>", function() ui.nav_file(3) end, "Harpoon file 3")
keymap("n", "<C-;>", function() ui.nav_file(4) end, "Harpoon file 4")
