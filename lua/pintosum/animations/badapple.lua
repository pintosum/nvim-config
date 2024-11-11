local custom = {
  fps = 10,
  name = 'bad_apple',
  com = 'doau User killreverb',
  clean = function()
    vim.cmd("doau User killreverb")
  end
}


custom.init = function(grid)
  custom.file = io.open("/home/serush/.config/nvim/lua/pintosum/play.txt", "r")
  vim.cmd("doautocmd User badapple");
end

local chars = '$@B%8&WM#*oahkbdpqwmZO0QLCJUYXzcvunxrjft/i\\|()1{}[]?-_+~<>i!lI;:,"^`\'. '

local function to_table(str)
  local t = {}
  for i = 1, #str do
    t[str:sub(i, i)] = i
  end
  return t
end

local function brightness(char)
  if (char == nil) then return 1 end


  --local i, j = string.find(chars, char, 1, true)
  --if i ~= j then error("brightness") end

  local i = custom.t[char]
  if i == nil then i = 10 end
  return i
end

local function lookup(t, index)
  for char, i in pairs(t) do
    if index == i then return char end
  end
  return ' '
end


local function rescale(grid, img)
  local height = #grid
  local width = #grid[1]
  local ratio = #img[1] / #img
  if (width / height) > ratio then
    width = math.floor(ratio * height + 0.5)
  elseif (width / height) < ratio then
    height = math.floor(width / ratio + 0.5)
  end
  local scale = height / #img

  for i = 1, height do
    for j = 1, width do
      --print(i / #grid * 30)
      local x = (i - 1) / scale
      local y = (j - 1) / scale
      local fx = math.floor(x) + 1
      local fy = math.floor(y) + 1
      if fx == #img then fx = fx - 1 end
      local int1 = (y - fy) * brightness(img[fx][fy]) + (fy - y + 1) * brightness(img[fx][fy + 1])
      local int2 = (y - fy) * brightness(img[fx + 1][fy]) + (fy - y + 1) * brightness(img[fx + 1][fy + 1])
      local int = (x - fx) * int1 + (fx - x + 1) * int2
      int = math.floor(int + 0.5)

      grid[i][j].char = lookup(custom.t, int)
      grid[i][j].hl_group = ""
    end
  end
end

custom.update = function(grid)
  local img = {}
  for i = 1, 30 do
    local line = custom.file:read();
    img[i] = {}
    if (line == nil) then
      custom.file:close(); return false;
    end
    for j = 1, 100 do
      img[i][j] = line:sub(j, j)
    end
  end
  custom.t = to_table(chars)
  rescale(grid, img)
  return true
end

require("cellular-automaton").register_animation(custom)
