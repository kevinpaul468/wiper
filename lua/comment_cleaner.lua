local function getPattern()
	local filetype = vim.bo.filetype
	local pattern = ""

	if filetype == "lua" then
		pattern = "%-%-"
	elseif filetype == "java" then
		pattern = "//"
	elseif filetype == "javascript" then
		pattern = "//"
	elseif filetype == "python" then
		pattern = "#"
	else
		pattern = filetype
	end
	return pattern
end


function RemoveComments()
	local pattern = getPattern()
	local not_commetns = {}
	local buf_id = vim.api.nvim_get_current_buf()
 	local filename = vim.api.nvim_buf_get_name(buf_id)
	local file = io.open(filename,"r")
	for line in file:lines() do
		if not line:match(pattern) then
			table.insert(not_commetns,line)
		end
	end
	file = io.open(filename,'w')
	for _,line in ipairs(not_commetns) do
		file:write(line .. "\n")
	end
	vim.cmd("bd")
	file:close()
	vim.cmd("edit ".. filename)
end
