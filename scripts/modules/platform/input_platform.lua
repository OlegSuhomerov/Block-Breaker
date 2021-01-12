
local app = require('scripts.service.app')
local rendercam = require('rendercam.rendercam')
local platform_movement = require('scripts.modules.platform.platform_movement')

local input_platform = {}

local game_messages = app.game_messages
local camera = app.camera

function input_platform.move(self, action, action_id)
	if action_id == game_messages.touch and action.pressed then

		local action_pos = rendercam.screen_to_world_2d(action.screen_x, action.screen_y, false)
		self.move = true
		
		if action_pos.x >= camera.center.x then
			platform_movement.right(self)
		else
			platform_movement.left(self)
		end
	elseif action.released then 
		self.move = false
		
	end
end

return input_platform