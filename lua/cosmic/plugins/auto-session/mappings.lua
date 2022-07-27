local map = require("cosmic.utils").map
local mapleader = require("cosmic.core.user").mapleader.as_string

-- session
map("n", mapleader .. "sl", "<Cmd>silent RestoreSession<CR>")
map("n", mapleader .. "ss", "<Cmd>SaveSession<CR>")
map("n", mapleader .. "sd", "<Cmd>DeleteSession<CR>")
map("n", mapleader .. "sD", ":DeleteSession", { silent = false })
map(
    "n",
    mapleader .. "si",
    '<Cmd>lua require("cosmic.utils.logger"):log("Session name: " .. require("auto-session-library").current_session_name())<CR>'
)
