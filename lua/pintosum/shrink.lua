local utf8 = require(".utf8")

local function shrink(width)
  local i = vim.api.nvim_get_option_value("filetype", {})
  if i == "markdown" or i == "text" then
    width = width or 80
    local bufnr = vim.api.nvim_get_current_buf()
    local buffer = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local ret = {}
    for _, line in ipairs(buffer) do
      while utf8.len(line) > width do
        local cut = utf8.offset(line, width)
        table.insert(ret, string.sub(line, 1, cut - 1))
        line = string.sub(line, cut);
      end
      table.insert(ret, line)
    end
    vim.api.nvim_buf_set_lines(bufnr, 0, #ret, false, ret)
  end
end

vim.keymap.set("n", "<leader>shr", shrink)

