local palette = require("gruvbox.palette")
local light = palette.get_base_colors({}, "light", "hard")
local dark = palette.get_base_colors({}, "dark", "")
dark.neutral_orange = "#d65d0e"

local colors = {
    white = light.bg0,
    bg = dark.bg0,
    bg_highlight = dark.bg1,
    normal = dark.neutral_yellow,
    insert = dark.neutral_green,
    command = dark.neutral_orange,
    visual = dark.neutral_purple,
    replace = dark.neutral_red,
    diffAdd = dark.neutral_green,
    diffModified = dark.neutral_orange,
    diffDeleted = dark.neutral_red,
    trace = dark.neutral_orange,
    hint = dark.neutral_blue,
    info = dark.neutral_green,
    error = dark.neutral_red,
    warn = dark.neutral_orange,
    floatBorder = dark.bg3,
    selection_caret = dark.neutral_blue,
}
return colors
