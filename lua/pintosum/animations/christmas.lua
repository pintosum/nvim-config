local tree = {
	fps = 4,
	name = "tree",
	grid = {
		{ " ", " ", " ", " ", "*", " ", " ", " ", " " },
		{ " ", " ", " ", "/", ".", "\\", " ", " ", " " },
		{ " ", " ", "/", "o", ".", ".", "\\", " ", " " },
		{ " ", " ", "/", ".", ".", "o", "\\", " ", " " },
		{ " ", "/", ".", "o", ".", ".", "o", "\\", " " },
		{ " ", "/", ".", ".", ".", "o", ".", "\\", " " },
		{ "/", ".", ".", "o", ".", ".", ".", ".", "\\" },
		{ "^", "^", "^", "[", "_", "]", "^", "^", "^" },
	},
	clean = function()
		ColorThis()
	end,
	style = {
		number = false,
		relativenumber = false,
	},
}

tree.init = function(grid)
	--vim.cmd("colorscheme christmas")

	--vim.api.nvim_set

	for i = 1, #grid do
		for j = 1, #grid[i] do
		if i <= 8 and j <= 9 then
				local char = tree.grid[i][j]
        local hl = ""
				if char == "o" then
					hl = "number"
				elseif char == "*" then
					hl = "String"
				elseif char == "[" or char == "]" or char == "_" then
					hl = "IncSearch"
				elseif char ~= " " then
					hl = "DiagnosticHint"
				end

				grid[i][j].char = char
				grid[i][j].hl_group = hl
			else
				grid[i][j].char = " "
			end
		end
	end
	--print(vim.inspect(tree.grid))
end

tree.update = function(grid)
	for i = 1, #grid do
		for j = 1, #grid[i] do
      local balls = "number"
      local star = "String"
      if (math.random(10) == 7) then balls = "Title"
      elseif (math.random(10) == 2) then balls = "DiagnosticInfo" end
      if (math.random(10) == 1) then star = "DiagnosticError" end
			if i <= 8 and j <= 9 then
				local char = tree.grid[i][j]
        --local hl = "DiagnosticHint"
				local hl = "Added"
				if char == "o" then
					hl = balls
				elseif char == "*" then
					hl = star
				elseif char == "[" or char == "]" or char == "_" then
					hl = "IncSearch"
				end

				grid[i][j].char = char
				grid[i][j].hl_group = hl
			else
				grid[i][j].char = " "
			end
		end
	end
  return true
end

require("cellular-automaton").register_animation(tree)
