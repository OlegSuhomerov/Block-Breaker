
local app = require('scripts.service.app')
local rendercam = require('rendercam.rendercam')

local input_ball = {}

local game_messages = app.game_messages

function input_ball.start(self, action_id, action)
	if action_id == game_messages.touch then
		self.action_pos = rendercam.screen_to_world_2d(action.screen_x, action.screen_y, false)
		self.ball_start = true
		return true
	end
end

return input_ball