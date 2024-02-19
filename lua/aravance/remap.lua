--- Set up a mapped key binding
--- @param m string|table the mode(s) to bind
--- @param l string the keys to bind
--- @param r string|function the action to perform
--- @param o string|table|nil the description or options to use to bind the mapping
local function keymap(m, l, r, o)
  local opts = {}
  if type(o) == "string" then
    opts.desc = o
  end
  if type(o) == "table" then
    opts = o
  end
  vim.keymap.set(m, l, r, opts)
end

vim.g.mapleader = " "

keymap("n", "<leader>pv", vim.cmd.Ex)

keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

keymap("n", "<leader>i", "i <left>")
keymap("n", "<leader>I", "I <left>")

keymap("n", "J", "mzJ`z")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap("n", "G", "Gzz")

keymap("x", "<leader>p", "\"_dP")

keymap({ "n", "v" }, "<leader>y", "\"+y", "Yank to clipboard")
keymap({ "n", "v" }, "<leader>Y", "\"+Y", "Yank to clipboard")

keymap("n", "Q", "<nop>")
keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", "tmux-sessionizer")

keymap("n", "<C-k>", "<cmd>cnext<CR>zz", "Next error")
keymap("n", "<C-j>", "<cmd>cprev<CR>zz", "Previous error")
keymap("n", "<leader>k", "<cmd>lnext<CR>zz", "Next location")
keymap("n", "<leader>j", "<cmd>lprev<CR>zz", "Previous location")

keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Replace in file")
keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make executable" })

keymap("c", "w!!", "execute 'silent! write !sudo tee % >/dev/null' <bar> edit!")
