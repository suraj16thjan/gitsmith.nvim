local window = require("gitsmith.window")

local M = {}

M.config = {
  cmd = "gitsmith",
  width = 0.85,
  height = 0.85,
  border = "rounded",
  title = " gitsmith ",
  title_pos = "center",
}

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

function M.open()
  window.open(M.config)
end

function M.toggle()
  window.toggle(M.config)
end

return M
