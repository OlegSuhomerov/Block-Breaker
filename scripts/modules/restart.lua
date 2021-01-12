
local app = require('scripts.service.app')
local menager_count_blocks = require('scripts.modules.block.menager_count_blocks')
local menager_energy = require('scripts.modules.menager_energy')

local restart = {}

local game_messages = app.game_messages
local game_components = app.game_components
local config = app.config

function restart.respawn_ball_and_platform()
	timer.delay(0.1, false, function()
		msg.post(game_components.platform, game_messages.respawn_platform)
		msg.post(game_components.balls, game_messages.respawn_ball)
	end)
end

function restart.restart_game()
	msg.post(game_components.game_scene_gui, game_messages.respawn_hp)
	msg.post(game_components.game_scene_gui, game_messages.set_img_chapter)
	msg.post(game_components.platform, game_messages.respawn_platform)
	msg.post(game_components.balls, game_messages.respawn_ball)
	msg.post(game_components.blocks, game_messages.respawn_blocks)
	menager_energy.take_energy()
	config.start_factor_speed_ball = 1
end

return restart