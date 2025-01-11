local function get_backing_window()
  local winds = vim.api.nvim_list_uis()
  return winds[1]
end

local function get()
end


local function create_float()
  local width = 12
  local height = 8
  local bufnr = vim.api.nvim_create_buf(false, true)
  local win_id = vim.api.nvim_open_win(bufnr, true, {
    relative = "editor",
    --row = math.floor(((vim.o.lines - height) / 2) - 1),
    --col = math.floor((vim.o.columns - width) / 2),
    row = vim.o.lines - 10,
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

local function chr_tree()
  local win_id, bufnr = create_float()
  vim.fn.win_execute(win_id, "CellularAutomaton tree")
end

chr_tree()

vim.api.nvim_create_autocmd('WinResized', {
  group = vim.api.nvim_create_augroup('pintosum', {}),
  pattern = '*',
  callback = function()
    vim.cmd("fclose")
    chr_tree()
  end
})
