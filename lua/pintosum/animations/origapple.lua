
local custom = {
  fps = 10,
  name = 'bad_apple_orig',
  com = 'doau User killreverb',
  clean = function()
    vim.cmd("doau User killreverb")
  end
}


custom.init = function(grid)
  custom.file = io.open("/home/serush/.config/nvim/lua/pintosum/play.txt", "r")
  vim.cmd("doautocmd User badapple");
  custom.g = {}
  for i = 1, 30 do custom.g[i] = {} end
end


custom.update = function (grid)
  for i = 1, 30 do
    local line = custom.file:read();
    if(line == nil) then custom.file:close(); return false; end
    for j = 1, 100 do
      grid[i][j].char = line:sub(j,j)
      grid[i][j].hl_group = ""
    end
  end

  return true
end

require("cellular-automaton").register_animation(custom)


