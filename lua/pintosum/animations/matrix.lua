local utf8 = require("utf8")

local matrix = {
  fps = 30,
  name = 'matrix',
  columns_row = {},
  columns_active = {},
  clean = function ()
    ColorThis()
  end
}

local function iter(t)
  local i = 0
  local n = #t
  return function ()
    i = i + 2
    if i <= n then return i end
  end
end


matrix.init = function(grid)
  vim.cmd("colorscheme matrix")
  for i = 1, #(grid[1]) do
    matrix.columns_row[i] = -1
    matrix.columns_active[i] = 0
    for j = 1, #grid do
      grid[j][i].char = ' '
      grid[j][i].hl_group = ""
    end
  end
end

matrix.update = function(grid)
  for i in iter(grid[1]) do
    if (matrix.columns_row[i] == -1) then
      matrix.columns_row[i] = math.random(#grid)
      matrix.columns_active[i] = math.random(2) - 1
    end
  end

  for i in iter(grid[1]) do
    if (matrix.columns_active[i] == 1) then
      local charcode = math.random(154)
      local char = ' '
      if (charcode < 28) then char = string.char(charcode + 64) else
      char = utf8.char((charcode - 27)%64 + 0xFF61) end
      grid[matrix.columns_row[i]][i].char = char
    else
      grid[matrix.columns_row[i]][i].char = ' '
    end

    matrix.columns_row[i] = matrix.columns_row[i] + 1

    if (matrix.columns_row[i] > #grid) then matrix.columns_row[i] = -1 end

    if (math.random(1000) == 0) then
      if (matrix.columns_active[i] == 0) then
        matrix.columns_active[i] = 1
      else
        matrix.columns_active[i] = 0
      end
    end
  end

  return true
end


require("cellular-automaton").register_animation(matrix)
