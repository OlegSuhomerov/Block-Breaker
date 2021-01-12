
local app = require('scripts.service.app')
local speed_ball = require('scripts.modules.ball.speed_ball')

local menager_ball = {}

local game_messages = app.game_messages
local game_components = app.game_components
local config = app.config
local go_constants = app.go_constants

menager_ball.list = {}

local function check_nil_data_ball(k)
	if menager_ball.list[k] ~= nil then
		return true
	end
end

function menager_ball.check_absence_ball()
	for k in pairs(menager_ball.list) do
		if check_nil_data_ball(k) then
			go.delete(menager_ball.list[k].url)
			menager_ball.list[k] = nil
		end
	end
end

local function check_last_ball()
	local last_ball = true
	for k in pairs(menager_ball.list) do 
		if check_nil_data_ball(k) then
			last_ball = false
		end
	end
	if last_ball then
		msg.post(game_components.platform, game_messages.release_input_focus)
		msg.post(game_components.game_level_gui, game_messages.ball_delete)
	end
end

function menager_ball.ball_not_play(self)
	go.delete(menager_ball.list[self.id_ball].url)
	menager_ball.list[self.id_ball] = nil
	check_last_ball()
end

function menager_ball.boost()
	for k in pairs(menager_ball.list) do
		speed_ball.speed_boost(menager_ball.list[k].collision_url)
	end
end

function menager_ball.stop_all_ball()
	for k in pairs(menager_ball.list) do
		if check_nil_data_ball(k) then
			menager_ball.list[k].present_speed = go.get(menager_ball.list[k].collision_url, game_messages.linear_velocity)
			go.set(menager_ball.list[k].collision_url, game_messages.linear_velocity, go_constants.stop_ball)
		end
	end
end

function menager_ball.play_all_ball()
	for k in pairs(menager_ball.list) do
		if check_nil_data_ball(k) then
			go.set(menager_ball.list[k].collision_url, game_messages.linear_velocity, menager_ball.list[k].present_speed)
			menager_ball.list[k].present_speed = nil
		end
	end
end

return menager_ball