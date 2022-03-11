local config = require("cosmic.core.user")
local u = require("cosmic.utils")

require("lsp_signature").setup(u.merge({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    hint_prefix = " ",
    toggle_key = "<C-k>",
    handler_opts = {
        border = config.border,
    },
    extra_trigger_chars = { "{" },
}, config.lsp_signature or {}))
