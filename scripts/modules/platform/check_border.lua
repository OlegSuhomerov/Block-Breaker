
local camera = require('scripts.service.camera')

local check_border = {}

function check_border.right_edge(self)
	local half_platform = self.size_platform.x / 2
	local right_edge_platform = self.pos.x + half_platform

	if right_edge_platform >= camera.right_top.x then
		return true
	end
end

function check_border.left_edge(self)
	local half_platform = self.size_platform.x / 2
	local left_edge_platform = self.pos.x - half_platform
	
	if left_edge_platform <= camera.left_bottom.x then
		return true
	end
end

return check_border