local function clock()
  return " " .. os.date("%H:%M")
end

-- show lsp progress in statusline
local function lsp_progress()
  local messages = vim.lsp.util.get_progress_messages()
  if #messages == 0 then
    return
  end
  local status = {}
  for _, msg in pairs(messages) do
    table.insert(status, (msg.percentage or 0) .. "%% " .. (msg.title or ""))
  end
  local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(ms / 120) % #spinners
  return table.concat(status, " | ") .. " " .. spinners[frame + 1]
end

vim.cmd([[autocmd User LspProgressUpdate let &ro = &ro]])

local config = {
  options = {
    -- theme = "onedark",
    theme = "material-nvim",
    section_separators = { "", "" },
    component_separators = { "", "" },
    -- section_separators = { "", "" },
    -- component_separators = { "", "" },
    icons_enabled = true,
  },
  tabline = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
      }
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  sections = {
    lualine_a = {
      {
        'mode',
        icon = nil, -- displays icon in front of the component
        separator = nil, -- overwrites component_separators for component
        condition = nil, -- condition function, component is loaded when function returns true
        -- custom color for component in format
        -- color = {fg = '#rrggbb', bg= '#rrggbb', gui='style'}
        -- or highlight group
        -- color = "WarningMsg"
        color = nil
      }
    },
    lualine_b = { "branch" },
    lualine_c = {
      { "diagnostics", sources = { "nvim_lsp" } },
      {
        'diff',
        colored = false, -- displays diff status in color if set to true
        -- all colors are in format #rrggbb
        color_added = nil, -- changes diff's added foreground color
        color_modified = nil, -- changes diff's modified foreground color
        color_removed = nil, -- changes diff's removed foreground color
        symbols = {added = '+', modified = '~', removed = '-'} -- changes diff symbols
      },
      "filename",
    },
    lualine_x = { "filetype", "progress", "location"},
    lualine_y = {},
    lualine_z = {lsp_progress},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { "nvim-tree", "quickfix"},
}

-- try to load matching lualine theme

local M = {}

function M.load()
  local name = vim.g.colors_name or ""
  local ok, _ = pcall(require, "lualine.themes." .. name)
  if ok then
    config.options.theme = name
  end
  require("lualine").setup(config)
end

M.load()

-- vim.api.nvim_exec([[
--   autocmd ColorScheme * lua require("config.lualine").load();
-- ]], false)

return M
