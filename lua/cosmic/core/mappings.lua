local map = require("cosmic.utils").map

-- Quickfix mappings
map("n", "<Leader>ck", "<Cmd>cexpr []<CR>")
map("n", "<Leader>cc", "<Cmd>cclose <CR>")
map("n", "<Leader>co", "<Cmd>copen <CR>")
map("n", "<Leader>cf", ":cfdo %s/")
map("n", "<Leader>cp", "<Cmd>cprev<CR>zz")
map("n", "<Leader>cn", "<Cmd>cnext<CR>zz")

-- tab navigation
map("n", "<Leader>tp", "<Cmd>tabprevious<CR>")
map("n", "<Leader>tn", "<Cmd>tabnext<CR>")
map("n", "<Leader>td", "<Cmd>tabclose<CR>")

-- resize with arrows
map("n", "<C-Up>", "<Cmd>resize -2<CR>")
map("n", "<C-Down>", "<Cmd>resize +2<CR>")
map("n", "<C-Left>", "<Cmd>vertical resize -2<CR>")
map("n", "<C-Right>", "<Cmd>vertical resize +2<CR>")
