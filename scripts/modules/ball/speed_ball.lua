
local app = require('scripts.service.app')

local speed_ball = {}

local go_constants = app.go_constants
local game_messages = app.game_messages
local game_components = app.game_components
local config = app.config

function speed_ball.check_slow_speed(speed, collision_url)
	local speed_x = math.abs(speed.x)
	local speed_y = math.abs(speed.y)
	if speed_x <= config.slow_speed then
		speed.x = speed.x * config.acceleration_ball
	end
	if speed_y <= config.slow_speed then
		speed.y = speed.y * config.acceleration_ball
	end
	go.set(collision_url, game_messages.linear_velocity, speed)
end

function speed_ball.boost_bonus_speed_up(collision_url)
	local given_speed = go.get(collision_url, game_messages.linear_velocity)
	go.set(collision_url, game_messages.linear_velocity, given_speed * config.bonus_speed_up)
	
	timer.delay(config.timer_speed_bonus, false, function()
		given_speed = go.get(collision_url, game_messages.linear_velocity)
		go.set(collision_url, game_messages.linear_velocity, given_speed / config.bonus_speed_up)
	end)
end

function speed_ball.boost_bonus_speed_down(collision_url)
	local given_speed = go.get(collision_url, game_messages.linear_velocity)
	go.set(collision_url, game_messages.linear_velocity, given_speed / config.bonus_speed_down)
	timer.delay(config.timer_speed_bonus, false, function()
		given_speed = go.get(collision_url, game_messages.linear_velocity)
		go.set(collision_url, game_messages.linear_velocity, given_speed * config.bonus_speed_up)
	end)
end

local function multiplier_increase()
	config.start_factor_speed_ball = config.start_factor_speed_ball + config.factor_speed_per_block
	return config.start_factor_speed_ball
end

function speed_ball.speed_boost(collision_url)
	local given_speed = go.get(collision_url, game_messages.linear_velocity)
	given_speed = given_speed / config.start_factor_speed_ball
	local multiplier = multiplier_increase()
	if multiplier >= config.max_factor_speed_ball then
		return
	end
	go.set(collision_url, game_messages.linear_velocity, given_speed * multiplier)
end

function speed_ball.speed_bonus_object(self, collision_url)
	local given_position = go.get_position()
	local pos = config.start_directions_bonus_ball
	msg.post(collision_url, game_messages.apply_force, {force = pos, position = given_position})
	timer.delay(0.1, false, function()
		local given_speed = go.get(collision_url, game_messages.linear_velocity)
		go.set(collision_url, game_messages.linear_velocity, given_speed * config.start_factor_speed_ball)
	end)
end

local function direction_calc(self, pos)
	
	local x = self.action_pos.x
	local y = self.action_pos.y - pos.y

	local hypotenuse = math.sqrt(math.pow(x, 2) + math.pow(y, 2))

	local sinA = x / hypotenuse
	local cosB = y / hypotenuse

	local x_force = config.start_speed_ball * sinA
	local y_force = config.start_speed_ball * cosB
	return vmath.vector3(x_force, y_force, 1), given_position
end

function speed_ball.create_speed_object(self, collision_url)
	local given_position = go.get_position()
	local pos = direction_calc(self, given_position)

	msg.post(collision_url, game_messages.apply_force, {force = pos, position = given_position})

	timer.delay(0.1, false, function()
		local given_speed = go.get(collision_url, game_messages.linear_velocity)
		go.set(collision_url, game_messages.linear_velocity, given_speed * config.start_factor_speed_ball)
	end)
end

return speed_ball