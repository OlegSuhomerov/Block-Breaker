
local app = require('scripts.service.app')

local config = app.config
local game_messages = app.game_messages
local game_components = app.game_components

local spawn_particles = {}

function spawn_particles.blocks_break(id_color)
	particlefx.play(game_components.break_block)
	particlefx.set_constant(game_components.break_block, game_messages.emitter, game_messages.tint, config.sprite_blocks[id_color].color)
end

function spawn_particles.blocks_hit(id_color)
	particlefx.play(game_components.block_hit)
	particlefx.set_constant(game_components.block_hit, game_messages.emitter, game_messages.tint, config.sprite_blocks[id_color].color)
end

return spawn_particles