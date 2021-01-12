
local app = require('scripts.service.app')

local game_components = app.game_components
local config = app.config
local game_messages = app.game_messages

local anim_button = {}

local play_anim = false

function anim_button.animation(id, self, action_id, action)
	
	local node = gui.get_node(id)
	
	if action_id == game_messages.touch and gui.pick_node(node, action.x, action.y) then
		if play_anim == false then
			
			gui.animate(node, game_messages.scale, 0.9, gui.PLAYBACK_LOOP_FORWARD, 0.2)

			play_anim = true
		end
	end
	if action.released then
		
		gui.animate(node, game_messages.scale, 1, gui.PLAYBACK_LOOP_FORWARD, 0.2, 0, function()
			play_anim = false
		end)
	end
end

return anim_button