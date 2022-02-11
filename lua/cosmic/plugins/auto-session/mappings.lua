local map = require("cosmic.utils").map

-- session
map("n", "<Leader>sl", "<Cmd>silent RestoreSession<CR>")
map("n", "<Leader>ss", "<Cmd>SaveSession<CR>")
map("n", "<Leader>sd", "<Cmd>DeleteSession<CR>")
map("n", "<Leader>sD", ":DeleteSession ", { silent = false })
map(
    "n",
    "<Leader>si",
    '<Cmd>lua require("cosmic.utils.logger"):log("Session name: " .. require("auto-session-library").current_session_name())<CR>'
)
