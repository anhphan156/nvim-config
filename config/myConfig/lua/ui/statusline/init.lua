local modes = {
  ["n"] = " N0RMAL",
  ["no"] = " N0RMAL",
  ["v"] = " VISUAL",
  ["V"] = " VISUAL LINE",
  [""] = " VISUAL BLOCK",
  ["s"] = " SELECT",
  ["S"] = " SELECT LINE",
  [""] = " SELECT BLOCK",
  ["i"] = " INSERT",
  ["ic"] = " INSERT",
  ["R"] = " REPLACE",
  ["Rv"] = " VISUAL REPLACE",
  ["c"] = " COMMAND",
  ["cv"] = " VIM EX",
  ["ce"] = " EX",
  ["r"] = " PROMPT",
  ["rm"] = " MOAR",
  ["r?"] = " CONFIRM",
  ["!"] = " SHELL",
  ["t"] = " TERMINAL",
}

local function mode()
  local current_mode = vim.api.nvim_get_mode().mode
  return string.format("%s", modes[current_mode]):upper()
end

vim.api.nvim_set_hl(0, "MyStatusLineBackground", { fg = "#eeeeee", bg = "#000000" })
vim.api.nvim_set_hl(0, "MyStatusLineAccent", { bg = "#ff0000" })
vim.api.nvim_set_hl(0, "MyStatusLineAccentInsert", { bg = "#398923" })
vim.api.nvim_set_hl(0, "MyStatusLineAccentVisual", { bg = "#ff309f" })
vim.api.nvim_set_hl(0, "MyStatusLineAccentCmdLine", { bg = "#00309f" })
vim.api.nvim_set_hl(0, "MyStatusLineBorder", { fg = "#ff0000", bg = "#000000" })
vim.api.nvim_set_hl(0, "MyStatusLineBorderInsert", { fg = "#398923", bg = "#000000" })
vim.api.nvim_set_hl(0, "MyStatusLineBorderVisual", { fg = "#ff309f", bg = "#000000" })
vim.api.nvim_set_hl(0, "MyStatusLineBorderCmdLine", { fg = "#00309f", bg = "#000000" })

local function update_mode_colors(comp)
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_color = "%#MyStatusLine" .. comp .. "#"
  if current_mode == "n" then
    mode_color = "%#MyStatusLine" .. comp .. "#"
  elseif current_mode == "i" or current_mode == "ic" then
    mode_color = "%#MyStatusLine" .. comp .. "Insert#"
  elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
    mode_color = "%#MyStatusLine" .. comp .. "Visual#"
  elseif current_mode == "R" then
    mode_color = "%#MyStatusLine" .. comp .. "Replace#"
  elseif current_mode == "c" then
    mode_color = "%#MyStatusLine" .. comp .. "CmdLine#"
  elseif current_mode == "t" then
    mode_color = "%#MyStatusLine" .. comp .. "Terminal#"
  end
  return mode_color
end

local function filepath()
  local fpath = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.:h")
  if fpath == "" or fpath == "." then
    return " "
  end

  return string.format(" %%<%s/", fpath)
end

local function filetype()
  return string.format(" %s ", vim.bo.filetype):upper()
end

Statusline = {}

Statusline.active = function()
  return table.concat {
    update_mode_colors('Border'),
    "",
    update_mode_colors('Accent'),
    "󰕷 ",
    update_mode_colors('Border'),
    "",
    update_mode_colors('Accent'),
    mode(),
    update_mode_colors('Border'),
    "",
    "%#MyStatusLineBackground#",
    " Testing",
    filepath(),
    "%=%#MyStatusLineBackground#",
    filetype(),
  }
end

function Statusline.inactive()
  return " %F"
end

function Statusline.short()
  return "%#StatusLineNC#   NvimTree"
end

vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
  augroup END
]], false)
