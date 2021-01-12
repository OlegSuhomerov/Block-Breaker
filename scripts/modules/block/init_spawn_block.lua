
local app = require('scripts.service.app')

local camera = app.camera
local config = app.config

local init_spawn_block = {}

local function calculation_indents(self)
	self.margin_x = camera.width * config.percent_margin_edge_board

	self.indent_wall_up = camera.hight * config.percent_indent_wall_up
	self.margin_y = (camera.hight - self.indent_wall_up) * config.percent_margin_edge_board
end

function init_spawn_block.block_scale(self)
	calculation_indents(self)
	
	local all_indent_x = self.margin_x * (self.dimension.strings + 1)
	local all_indent_y = self.margin_y * (self.dimension.columns + 1) - self.indent_wall_up * 2

	local distance_block_x = (camera.width - all_indent_x) / self.dimension.strings
	local distance_block_y = (camera.hight - all_indent_y) / self.dimension.columns

	local scale_x = distance_block_x / config.size_block.x
	local scale_y = distance_block_y / config.size_block.y

	if scale_x < scale_y then
		return scale_x
	else
		return scale_y
	end
end

return init_spawn_block