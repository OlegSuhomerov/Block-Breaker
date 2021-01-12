
local app = require('scripts.service.app')

local camera = app.camera
local config = app.config

local position_block = {}

function position_block.pos_blocks(self, i, j)

	local game_width_block = config.size_block.x * self.scale
	local game_hight_block = config.size_block.y * self.scale

	local pos_x = camera.left_bottom.x + self.margin_x * i + game_width_block * 0.5 + game_width_block * (i-1)
	local pos_y = camera.right_top.y - self.indent_wall_up - self.margin_y * j - game_hight_block * 0.5 - game_hight_block * (j-1)

	return vmath.vector3(pos_x, pos_y, 1)
end

return position_block