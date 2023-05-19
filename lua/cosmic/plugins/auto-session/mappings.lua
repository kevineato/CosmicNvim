local map = require("cosmic.utils").map
local mapleader = require("cosmic.core.user").mapleader.as_string
local auto_session = require("auto-session")
local session_lens = require("auto-session.session-lens")
local as_lib = require("auto-session.lib")

-- session
map("n", mapleader .. "sl", function()
    auto_session.RestoreSession("")
end)
map("n", mapleader .. "ss", function()
    auto_session.SaveSession("", false)
end)
map("n", mapleader .. "sa", function()
    session_lens.search_session()
end)
map("n", mapleader .. "sd", function()
    auto_session.DeleteSession("")
end)
map("n", mapleader .. "si", function()
    require("cosmic.utils.logger"):log(
        "Session name: " .. as_lib.current_session_name()
    )
end)
