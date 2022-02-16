local map = require("cosmic.utils").map

map("n", "<C-n>", "<Cmd>lua require('nvim-tree').toggle(false)<CR>")
map("n", "<Leader>fn", "<Cmd>lua require('nvim-tree').toggle(true)<CR>")
