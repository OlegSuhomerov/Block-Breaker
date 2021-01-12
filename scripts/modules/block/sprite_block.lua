
local app = require('scripts.service.app')

local sprite_block = {}

local config = app.config
local game_messages = app.game_messages

function sprite_block.idle(id_color)
	msg.post(".", game_messages.play_animation, {id = hash(config.sprite_blocks[id_color][config.id_start_animate_block])})
end

function sprite_block.broken(id_color)
	msg.post(".", game_messages.play_animation, {id = hash(config.sprite_blocks[id_color][config.id_broken_animate_block])})
end

return sprite_block