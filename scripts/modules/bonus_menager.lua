
local app = require('scripts.service.app')
local menager_count_blocks = require('scripts.modules.block.menager_count_blocks')
local menager_ball = require('scripts.modules.ball.menager_ball')
local speed_ball = require('scripts.modules.ball.speed_ball')

local bonus_menager = {}

local config = app.config
local game_messages = app.game_messages

local function fire_ball(self)
	for k,v in pairs(menager_ball.list) do
		if v ~= nil then
			msg.post(v.url, game_messages.bonus_fire_ball)
		end
	end
end

local function speed_platform_down(self)
	msg.post(game_components.platform, game_messages.bonus_speed_platform_down)
end

local function speed_platform_up(self)
	msg.post(game_components.platform, game_messages.bonus_speed_platform_up)
end

local function bonus_heart(self)
	msg.post(game_components.game_level_gui, game_messages.bonus_heart)
end

local function black_heart(self)
	msg.post(game_components.game_level_gui, game_messages.black_heart)
end

local function add_bonus_ball(self)
	for k,v in pairs(menager_ball.list) do
		if v ~= nil then
			local pos = go.get_position(v.url)
			msg.post(game_components.balls, game_messages.create_ball, {pos = pos})
			return
		end
	end
end

local function speed_down_ball(self)
	for k,v in pairs(menager_ball.list) do
		if v ~= nil then
			msg.post(v.url, game_messages.bonus_speed_ball_down)
		end
	end
end

local function speed_up_ball(self)
	for k,v in pairs(menager_ball.list) do
		if v ~= nil then
			msg.post(v.url, game_messages.bonus_speed_ball_up)
		end
	end
end

local function spawn_bonus(self)
	local property = {cords = menager_count_blocks.list[self.id].cords, bonus_id = self.bonus_id}
	msg.post(game_components.spawn_bonus, game_messages.spawn_bonus, property)
end

local function horizontal_bomb(self)
	local j = menager_count_blocks.list[self.id].pos.j
	for k,v in pairs(menager_count_blocks.list) do
		if v.pos.j == j and v.settings.invulnerability ~= true and k ~= self.id then
			msg.post(v.url, game_messages.delete_block)
		end
	end
end

local function vertical_bomb(self)
	local i = menager_count_blocks.list[self.id].pos.i
	for k,v in pairs(menager_count_blocks.list) do
		if v.pos.i == i and v.settings.invulnerability ~= true and k ~= self.id then
			msg.post(v.url, game_messages.delete_block)
		end
	end
end

local function chain_bomb(self)
	local i = menager_count_blocks.list[self.id].pos.i
	local j = menager_count_blocks.list[self.id].pos.j
	local max_count = 0
	local delete_id_color = 0
	local neighbors_colors = {}
	for k,v in pairs(menager_count_blocks.list) do
		if (v.pos.i + 1 == i and v.pos.j == j)
		or (v.pos.i == i and v.pos.j + 1 == j)
		or (v.pos.i == i and v.pos.j - 1 == j)
		or (v.pos.i - 1 == i and v.pos.j == j) then
			if not v.settings.invulnerability then
				if neighbors_colors[v.settings.id_color] == nil then
					neighbors_colors[v.settings.id_color] = 1
				else
					neighbors_colors[v.settings.id_color] = neighbors_colors[v.settings.id_color] + 1
				end
			end
		end
	end
	for k,v in pairs(neighbors_colors) do
		if v >= max_count then
			max_count = v
			delete_id_color = k
		end
	end
	for k,v in pairs(menager_count_blocks.list) do
		if v.settings.id_color == delete_id_color and k ~= self.id then
			msg.post(v.url, game_messages.delete_block)
		end
	end
end

local function bomb(self)
	local i = menager_count_blocks.list[self.id].pos.i
	local j = menager_count_blocks.list[self.id].pos.j
	for k,v in pairs(menager_count_blocks.list) do
		if (v.pos.i + 1 == i  and v.pos.j + 1 == j)
		or (v.pos.i + 1 == i and v.pos.j == j)
		or (v.pos.i == i and v.pos.j + 1 == j)
		or (v.pos.i == i and v.pos.j - 1 == j)
		or (v.pos.i - 1 == i and v.pos.j == j)
		or (v.pos.i - 1 == i and v.pos.j - 1 == j)
		or (v.pos.i - 1 == i and v.pos.j + 1 == j)
		or (v.pos.i + 1 == i and v.pos.j - 1 == j) then
			if v.settings.invulnerability ~= true and k ~= self.id then
				msg.post(v.url, game_messages.delete_block)
			end
		end
	end	
end

function bonus_menager.contact_bonus_platform(self)
	if self.bonus_id == 5 then
		speed_up_ball(self)
	elseif self.bonus_id == 6 then
		speed_down_ball(self)
	elseif self.bonus_id == 7 then
		add_bonus_ball(self)
	elseif self.bonus_id == 8 then
		black_heart(self)
	elseif self.bonus_id == 9 then
		bonus_heart(self)
	elseif self.bonus_id == 10 then
		speed_platform_up(self)
	elseif self.bonus_id == 11 then
		speed_platform_down(self)
	elseif self.bonus_id == 12 then
		fire_ball(self)
	end
end

function bonus_menager.check_bonus(self)
	if self.bonus_id == 1 then
		bomb(self)
	elseif self.bonus_id == 2 then
		chain_bomb(self)
	elseif self.bonus_id == 3 then
		vertical_bomb(self)
	elseif self.bonus_id == 4 then
		horizontal_bomb(self)
	elseif self.bonus_id >= 5 and self.bonus_id <= 12 then
		spawn_bonus(self)
	end
end

return bonus_menager