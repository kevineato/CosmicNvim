local palette = require("gruvbox").palette

local colors = {
    white = palette.light0_hard,
    bg = palette.dark0,
    bg_highlight = palette.dark1,
    normal = palette.neutral_yellow,
    insert = palette.neutral_green,
    command = palette.neutral_orange,
    visual = palette.neutral_purple,
    replace = palette.neutral_red,
    diffAdd = palette.neutral_green,
    diffModified = palette.neutral_orange,
    diffDeleted = palette.neutral_red,
    trace = palette.neutral_orange,
    hint = palette.neutral_blue,
    info = palette.neutral_green,
    error = palette.neutral_red,
    warn = palette.neutral_orange,
    floatBorder = palette.dark3,
    selection_caret = palette.neutral_blue,
}
return colors
