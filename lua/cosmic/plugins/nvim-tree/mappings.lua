local map = require("cosmic.utils").map
local mapleader = require("cosmic.core.user").mapleader.as_string

map("n", "<C-n>", function()
    require("nvim-tree").toggle(false)
end)
map("n", mapleader .. "fn", function()
    require("nvim-tree").toggle(true)
end)
