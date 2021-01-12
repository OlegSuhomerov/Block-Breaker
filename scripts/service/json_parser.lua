
local json_parser = {}

function json_parser.parse(url)
	local matrix, error = sys.load_resource(url)
	if matrix then
		return json.decode(matrix)
	else
		print(error)
	end
end

return json_parser