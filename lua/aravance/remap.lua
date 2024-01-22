vim.g.mapleader = " "
local function map(m, l, r, opts)
  vim.keymap.set(m, l, r, opts)
end

map("n", "<leader>pv", vim.cmd.Ex)

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "<leader>i", "i <esc>i")
map("n", "<leader>a", "a <esc>i")
map("n", "<leader>I", "I <esc>i")
map("n", "<leader>A", "A <esc>i")

map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "G", "Gzz")

map("x", "<leader>p", "\"_dP")

map({ "n", "v" }, "<leader>y", "\"+y", { desc = "Yank to clipboard" })
map({ "n", "v" }, "<leader>Y", "\"+Y", { desc = "Yank to clipboard" })

map("n", "Q", "<nop>")
map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "tmux-sessionizer" })
map("n", "<leader>f", vim.lsp.buf.format, { desc = "[F]ormat file" })

map("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next error" })
map("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Previous error" })
map("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next location" })
map("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Previous location" })

map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace in file" })
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make executable" })

map("c", "w!!", "execute 'silent! write !sudo tee % >/dev/null' <bar> edit!")
