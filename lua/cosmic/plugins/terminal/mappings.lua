local map = require('cosmic.utils').map

map('n', '<C-t>', '<Cmd>FloatermToggle<CR>')
map('t', '<C-t>', [[<C-\><C-n>]])
map('t', [[<C-\>l]], [[<C-\><C-n><Cmd>FloatermNext<CR>]])
map('t', [[<C-\>h]], [[<C-\><C-n><Cmd>FloatermPrev<CR>]])
map('t', [[<C-\>n]], [[<C-\><C-n><Cmd>FloatermNew<CR>]])
map('t', [[<C-\>c]], [[<C-\><C-n><Cmd>FloatermKill<CR>]])
