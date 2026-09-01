local M = {}

local state = {
  buf = nil,
  win = nil,
  chan = nil,
}

local function is_valid()
  return state.buf
    and vim.api.nvim_buf_is_valid(state.buf)
    and state.win
    and vim.api.nvim_win_is_valid(state.win)
end

local function calc_dimensions(config)
  local ui = vim.api.nvim_list_uis()[1] or { width = 120, height = 40 }
  local width = config.width <= 1 and math.floor(ui.width * config.width) or config.width
  local height = config.height <= 1 and math.floor(ui.height * config.height) or config.height
  local row = math.floor((ui.height - height) / 2)
  local col = math.floor((ui.width - width) / 2)
  return width, height, row, col
end

local function create_window(config)
  local width, height, row, col = calc_dimensions(config)

  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].filetype = "gitsmith"

  local win_opts = {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = config.border,
    title = config.title,
    title_pos = config.title_pos,
    zindex = 50,
  }

  local win = vim.api.nvim_open_win(buf, true, win_opts)
  vim.wo[win].winblend = 0

  local cwd = vim.fn.getcwd()
  local chan = vim.fn.termopen(config.cmd, {
    cwd = cwd,
    on_exit = function()
      if state.win and vim.api.nvim_win_is_valid(state.win) then
        vim.api.nvim_win_close(state.win, true)
      end
      state.buf = nil
      state.win = nil
      state.chan = nil
    end,
  })

  vim.cmd("startinsert")

  state.buf = buf
  state.win = win
  state.chan = chan
end

function M.open(config)
  if is_valid() then
    vim.api.nvim_set_current_win(state.win)
    vim.cmd("startinsert")
    return
  end
  create_window(config)
end

function M.close()
  if is_valid() then
    vim.api.nvim_win_close(state.win, true)
  end
end

function M.toggle(config)
  if is_valid() then
    vim.api.nvim_win_hide(state.win)
    return
  end

  if state.buf and vim.api.nvim_buf_is_valid(state.buf) then
    local width, height, row, col = calc_dimensions(config)
    state.win = vim.api.nvim_open_win(state.buf, true, {
      relative = "editor",
      width = width,
      height = height,
      row = row,
      col = col,
      style = "minimal",
      border = config.border,
      title = config.title,
      title_pos = config.title_pos,
      zindex = 50,
    })
    vim.cmd("startinsert")
    return
  end

  create_window(config)
end

return M
