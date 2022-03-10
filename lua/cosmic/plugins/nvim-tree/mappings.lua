local map = require("cosmic.utils").map
local mapleader = require("cosmic.core.user").mapleader.as_string

map("n", "<C-n>", "<Cmd>lua require('nvim-tree').toggle(false)<CR>")
map("n", mapleader .. "fn", "<Cmd>lua require('nvim-tree').toggle(true)<CR>")
