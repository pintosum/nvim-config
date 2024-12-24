
local function create_float()
  local win = vim.api.nvim_list_uis()

  local width = 12

  local height = 10
  local bufnr = vim.api.nvim_create_buf(false, true)
  local win_id = vim.api.nvim_open_win(bufnr, true, {
    relative = "editor",
    --title = "Redcorner",
    --title_pos = "center",
    --row = math.floor(((vim.o.lines - height) / 2) - 1),
    --col = math.floor((vim.o.columns - width) / 2),
    row = 0,
    col = vim.o.columns - 1,
    width = width,
    height = height,
    style = "minimal",
    --border = "single",
    hide = true,
  })

  win_id = win_id
  vim.api.nvim_set_option_value("number", false, {
    win = win_id,
  })


  vim.api.nvim_set_option_value("filetype", "lua", {
    buf = bufnr
  })

  return win_id, bufnr
end

local win_id, bufnr = create_float()

vim.fn.win_execute(win_id, "CellularAutomaton tree")


