local notify = require("notify")

notify.setup({
  stages = "fade_in_slide_out",
  timeout = 3000,
  top_down = false,
  my_cool_setting = true,
  background_color = "NONE"
})

vim.notify = notify

-- Colors
vim.api.nvim_set_hl(0, "NotifyINFOBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "NotifyINFOBody", { bg = "none" })
vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "NotifyDEBUGBody", { bg = "none" })
vim.api.nvim_set_hl(0, "NotifyWARNBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "NotifyWARNBody", { bg = "none" })
vim.api.nvim_set_hl(0, "NotifyERRORBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "NotifyERRORBody", { bg = "none" })
vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "NotifyTRACEBody", { bg = "none" })
