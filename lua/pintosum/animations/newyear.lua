local tree = {
  fps = 20,
  name = "tree",
}

tree.init = function(grid)
  local file = io.open("~/.config/nvim/lua/pintosum/animations/christmas_tree.txt")
  if (file == nil) then return false end
  tree.grid = {}
  for i = 1, 8 do
    local line = file:read()
    tree.grid[i] = {}
    if (line == nil) then
      file:close(); return false;
    end
    for j = 1, 9 do
      tree.grid[i][j] = line:sub(j, j)
    end
  end
  vim.api.nvim_set_option(0, 'filetype', 'lua')
end

tree.update = function(grid)
  for i = 1, 8 do
    for j = 1, 9 do
      local char = tree.grid[i][j]
      local hl = "variable.member"
      grid[i][j].char = char
      if (char == 'o') then
        hl = "module.builtin"
      elseif (char == '*') then
        hl = "String"
      elseif (char == '[' or char == ']' or char == '_') then
        hl = "function"
      end
      grid[i][j].hl_group = hl
    end
  end
end
