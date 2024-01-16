vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- alacritty + tmux can be difficult, so we remap alacritty to send ^W on ^Backspace
--[=[
cat >>~/.config/alacritty/alacritty.toml <<EOF
[[keyboard.bindings]]
# tmux doesn't support ctrl-backspace -- map it to ctrl-w
key = "Back"
mods = "Control"
chars = "\u0017"
EOF
--]=]
-- then we remap <c-w> here
vim.api.nvim_set_keymap("n", "<c-w>", "<c-backspace>", {})
vim.api.nvim_set_keymap("c", "<c-w>", "<c-backspace>", {})
vim.api.nvim_set_keymap("i", "<c-w>", "<c-backspace>", {})
vim.api.nvim_set_keymap("v", "<c-w>", "<c-backspace>", {})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "G", "Gzz")

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "[F]ormat file" })

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace in file" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make executable" })

vim.keymap.set("c", "w!!", "execute 'silent! write !sudo tee % >/dev/null' <bar> edit!")
