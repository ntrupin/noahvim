-- notify.lua
-- notify configurations

local M = {}

M.config = function()
  vim.notify = require("notify")
end

return M
