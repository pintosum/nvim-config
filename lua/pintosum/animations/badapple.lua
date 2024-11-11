
local custom = {
  fps = 8,
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
  if(char == nil) then return 1 end

  local i = custom.t[char]
  if i == nil then i = 70 end
  return i
end

local function lookup(t, index)
  for char, i in pairs(t) do
    if index == i then return char end
  end
  return ' '
end


local function mul_matr(m1, m2)
    if #m1[1] ~= #m2 then       -- inner matrix-dimensions must agree
        return nil
    end
    local res = {}

    for i = 1, #m1 do
        res[i] = {}
        for j = 1, #m2[1] do
            res[i][j] = 0
            for k = 1, #m2 do
                res[i][j] = res[i][j] + m1[i][k] * m2[k][j]
            end
        end
    end
    return res
end


local function p(t, f)
  local mat = { {0,2,0,0},
                {-1,0,1,0},
                {2,-5,4,-1},
                {-1,3,-3,1},}
  local tt = { {0.5, t/2, t*t/2, t*t*t/2} }
  local ret = mul_matr(mul_matr(tt, mat), f)
  return ret
end


local function rescale_bicubic(grid, img)

  local height = #grid
  local width = #grid[1]
  local ratio = #img[1]/#img
  if (width / height) > ratio then width = math.floor(ratio * height + 0.5)
  else height = math.floor(width / ratio + 0.5) end
  local scale = height / #img

  for i = 1, height do
    for j = 1, width do
      local x = (i-1)/scale
      local y = (j-1)/scale
      local fx = math.floor(x)+1
      local fy = math.floor(y)+1


      local b0,b1,b2,b3,ret
      if(fx < #img - 2 and fx > 1 and fy < #img - 2 and fy > 1) then
      b0 = p( x-fx, {{brightness(img[fx-1][fy-1])}, {brightness(img[fx][fy-1])}, {brightness(img[fx+1][fy-1])}, {brightness(img[fx+2][fy-1])},})
      b1 = p( x-fx, {{brightness(img[fx-1][fy])}, {brightness(img[fx][fy])}, {brightness(img[fx+1][fy])}, {brightness(img[fx+2][fy])},})
      b2 = p( x-fx, {{brightness(img[fx-1][fy+1])}, {brightness(img[fx][fy+1])}, {brightness(img[fx+1][fy+1])}, {brightness(img[fx+2][fy+1])},})
      b3 = p( x-fx, {{brightness(img[fx-1][fy+2])}, {brightness(img[fx][fy+2])}, {brightness(img[fx+1][fy+2])}, {brightness(img[fx+2][fy+2])},})
      ret = p( y-fy, {{b0[1][1]}, {b1[1][1]}, {b2[1][1]}, {b3[1][1]},})
      ret = math.floor(ret[1][1]+0.5)
      else ret = brightness(img[fx][fy])end
      grid[i][j].char = lookup(custom.t, ret)
      grid[i][j].hl_group = ""
    end
  end

end


local function rescale(grid, img)

  local height = #grid
  local width = #grid[1]
  local ratio = #img[1] / #img
  if (width / height) > ratio then width = math.floor(ratio * height + 0.5)
  elseif (width / height) < ratio then height = math.floor(width / ratio + 0.5) end
  local scale = height / #img

  for i = 1, height do
    for j = 1, width do
      --print(i / #grid * 30)
      local x = (i-1) / scale
      local y = (j-1) / scale
      local fx = math.floor(x)+1
      local fy = math.floor(y)+1
      --if fx == #img then fx = fx - 1 end
      local int
      if fx ~= #img then
      local int1 = (y - fy)*brightness(img[fx][fy]) + (fy - y + 1)*brightness(img[fx][fy+1])
      local int2 = (y - fy)*brightness(img[fx+1][fy]) + (fy - y + 1)*brightness(img[fx+1][fy+1])
      int = (x - fx)*int1 + (fx - x + 1)*int2
      int = math.floor(int+0.5)
      else int = brightness(img[fx][fy]) end
      grid[i][j].char = lookup(custom.t, int)
      grid[i][j].hl_group = ""
    end
  end


end

custom.update = function (grid)
  local img = {}
  for i = 1, 30 do
    local line = custom.file:read();
    img[i] = {}
    if(line == nil) then custom.file:close(); return false; end
    for j = 1, 100 do
      img[i][j] = line:sub(j,j)
    end
  end
  custom.t = to_table(chars)
  rescale_bicubic(grid, img)
  return true
end

require("cellular-automaton").register_animation(custom)


