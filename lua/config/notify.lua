-- notify.lua
-- notify configurations

local M = {}

M.setup = function()
  vim.notify = require("notify")
end

return M
