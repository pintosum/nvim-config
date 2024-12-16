local tree = {
  fps = 20,
  name = "tree",
  grid = { { ' ', ' ', ' ', ' ', '*', ' ', ' ', ' ', ' ' },
    { ' ', ' ', ' ', '/', '.', '\\', ' ',  ' ',  ' ' },
    { ' ', ' ', '/', 'o', '.', '.',  '\\', ' ',  ' ' },
    { ' ', ' ', '/', '.', '.', 'o',  '\\', ' ',  ' ' },
    { ' ', '/', '.', 'o', '.', '.',  'o',  '\\', ' ' },
    { ' ', '/', '.', '.', '.', 'o',  '.',  '\\', ' ' },
    { '/', '.', '.', 'o', '.', '.',  '.',  '.',  '\\' },
    { '^', '^', '^', '[', '_', ']',  '^',  '^',  '^' },
  },
  clean = function()
    ColorThis()
  end,
}

tree.init = function(grid)
  --vim.cmd("colorscheme christmas")

  --vim.api.nvim_set


  for i = 1, #grid do
    for j = 1, #grid[i] do
      if (i <= 8 and j <= 9) then
        local char = tree.grid[i][j]
        local hl
        if (char == 'o') then
          hl = "module.builtin"
        elseif (char == '*') then
          hl = "String"
        elseif (char == '[' or char == ']' or char == '_') then
          hl = "function"
        end

        grid[i][j].char = char
        grid[i][j].hl_group = hl
      else
        grid[i][j].char = ' ';
      end
    end
  end
  --print(vim.inspect(tree.grid))
end

tree.update = function(grid)
  for i = 1, #grid do
    for j = 1, #(grid[i]) do
      if (i < 8 and j < 9) then
        local char = tree.grid[i][j]
        local hl
        if (char == 'o') then
          hl = "module.builtin"
        elseif (char == '*') then
          hl = "String"
        elseif (char == '[' or char == ']' or char == '_') then
          hl = "function"
        end

        grid[i][j].char = char
        grid[i][j].hl_group = hl
      else
        grid[i][j].char = ' ';
      end
    end
  end
end

require("cellular-automaton").register_animation(tree)
