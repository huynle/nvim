local cmd = vim.cmd

local global_theme = "themes/" .. vim.g.mytheme
local colors = require(global_theme)

local white = colors.white
local darker_black = colors.darker_black
local black = colors.black
local black2 = colors.black2
local one_bg = colors.one_bg
local one_bg2 = colors.one_bg2
local one_bg3 = colors.one_bg3
local light_grey = colors.light_grey
local grey = colors.grey
local grey_fg = colors.grey_fg
local grey_fg2 = colors.grey_fg2
local red = colors.red
local line = colors.line
local green = colors.green
local nord_blue = colors.nord_blue
local blue = colors.blue
local yellow = colors.yellow
local purple = colors.purple

-- for guifg , bg

local function fg(group, color)
    cmd("hi " .. group .. " guifg=" .. color)
end

local function bg(group, color)
    cmd("hi " .. group .. " guibg=" .. color)
end

local function fg_bg(group, fgcol, bgcol)
    cmd("hi " .. group .. " guifg=" .. fgcol .. " guibg=" .. bgcol)
end

-- blankline

fg("indentblanklinechar", line)

-- misc --
fg("linenr", grey)
fg("comment", grey_fg2)
fg("nviminternalerror", red)
fg("vertsplit", line)
fg("endofbuffer", black)

-- pmenu
bg("pmenu", one_bg)
bg("pmenusbar", one_bg2)
bg("pmenusel", green)
bg("pmenuthumb", nord_blue)

-- inactive statuslines as thin splitlines
cmd("hi! statuslinenc gui=underline guifg=" .. line)

-- line n.o
cmd "hi clear cursorline"
fg("cursorlinenr", white)

-- git signs ---
fg_bg("diffadd", nord_blue, "none")
fg_bg("diffchange", one_bg2, "none")
fg_bg("diffmodified", nord_blue, "none")

-- nvimtree
fg("nvimtreefoldericon", blue)
fg("nvimtreefoldername", blue)
fg("nvimtreeopenedfoldername", blue)
fg("nvimtreeemptyfoldername", blue)
fg("nvimtreeindentmarker", one_bg2)
fg("nvimtreevertsplit", darker_black)
bg("nvimtreevertsplit", darker_black)
fg("nvimtreeendofbuffer", darker_black)

fg("nvimtreerootfolder", darker_black)
bg("nvimtreenormal", darker_black)
fg_bg("nvimtreestatuslinenc", darker_black, darker_black)
fg_bg("nvimtreewindowpicker", red, black2)

-- telescope
fg("telescopeborder", line)
fg("telescopepromptborder", line)
fg("telescoperesultsborder", line)
fg("telescopepreviewborder", grey)

-- lspdiagnostics ---

-- error / warnings
fg("lspdiagnosticssignerror", red)
fg("lspdiagnosticsvirtualtexterror", red)
fg("lspdiagnosticssignwarning", yellow)
fg("lspdiagnosticsvirtualtextwarning", yellow)

-- info
fg("lspdiagnosticssigninformation", green)
fg("lspdiagnosticsvirtualtextinformation", green)

-- hint
fg("lspdiagnosticssignhint", purple)
fg("lspdiagnosticsvirtualtexthint", purple)

-- bufferline

fg_bg("bufferlinefill", grey_fg, black2)
fg_bg("bufferlinebackground", light_grey, black2)

fg_bg("bufferlinebuffervisible", light_grey, black2)
fg_bg("bufferlinebufferselected", white, black)

cmd "hi bufferlinebufferselected gui=bold"

-- tabs
fg_bg("bufferlinetab", light_grey, one_bg3)
fg_bg("bufferlinetabselected", black2, nord_blue)
fg_bg("bufferlinetabclose", red, black)

fg_bg("bufferlineindicator", black2, black2)
fg_bg("bufferlineindicatorselected", black, black)

-- separators
fg_bg("BufferLineSeparator", black2, black2)
fg_bg("BufferLineSeparatorVisible", black2, black2)
fg_bg("BufferLineSeparatorSelected", black, black2)

-- modified buffers
fg_bg("BufferLineModified", red, black2)
fg_bg("BufferLineModifiedVisible", red, black2)
fg_bg("BufferLineModifiedSelected", green, black)

-- close buttons
fg_bg("BufferLineCLoseButtonVisible", light_grey, black2)
fg_bg("BufferLineCLoseButton", light_grey, black2)
fg_bg("BufferLineCLoseButtonSelected", red, black)

-- dashboard

fg("DashboardHeader", grey_fg)
fg("DashboardCenter", grey_fg)
fg("DashboardShortcut", grey_fg)
fg("DashboardFooter", grey_fg)

-- packer's floating window

bg("NormalFloat", black2)
bg("FloatBorder", black2)
fg("FloatBorder", black2)

-- set bg color for nvim ( so nvim wont use terminal bg)

bg("Normal", black)
