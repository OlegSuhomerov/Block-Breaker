
local json_parser = require('scripts.service.json_parser')
local app = require('scripts.service.app')

local get_matrix_blocks = {}

local config = app.config

local function parse_json_settings_blocks()
	return json_parser.parse(game_components.settings_blocks)
end

local function parse_json_data_blocks(num_level)
	return json_parser.parse(config.data_levels[num_level].level)
end

function get_matrix_blocks.get_data(num_level)
	local matrix_data = parse_json_data_blocks(num_level)
	local settings_blocks = parse_json_settings_blocks()
	local index = 0
	
	for i = 1, matrix_data.dimension.strings do
		for j = 1, matrix_data.dimension.columns do
			index = index + 1
			if matrix_data.block_list[index] then
				matrix_data.block_list[index].pos = {i = i, j = j}
				matrix_data.block_list[index].settings = settings_blocks.settings[matrix_data.block_list[index].group_settings]
				matrix_data.block_list[index].group_settings = nil
			end
		end
	end
	local demension = {strings = matrix_data.dimension.strings, columns = matrix_data.dimension.columns}
	return matrix_data.block_list, demension
end

return get_matrix_blocks