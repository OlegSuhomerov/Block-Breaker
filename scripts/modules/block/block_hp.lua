
local app = require('scripts.service.app')
local sprite_block = require('scripts.modules.block.sprite_block')
local spawn_particles = require('scripts.modules.spawn_particles')
local bonus_menager = require('scripts.modules.bonus_menager')

local block_hp = {}

local config = app.config
local game_messages = app.game_messages

local function check_hp_events(self)
	if self.hp <= 0 then
		if self.bonus_id ~= 0 then
			bonus_menager.check_bonus(self)
		end
		msg.post(".", game_messages.delete_block)
		return
	elseif self.hp <= (self.start_hp / 2) then
		sprite_block.broken(self.id_color)
	end
	spawn_particles.blocks_hit(self.id_color)
end

function block_hp.pick_up(self)
	self.hp = self.hp - config.block_damage
	check_hp_events(self)
end

return block_hp