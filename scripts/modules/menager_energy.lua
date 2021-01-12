
local record = require('scripts.service.record')
local app = require('scripts.service.app')
local time_menager = require('scripts.service.time_menager')

local menager_energy = {}

menager_energy.energy = {}
local energy = menager_energy.energy
local config = app.config

local function check_count_energy()
	if energy.max_count > energy.count then
		return true
	end
end

local function check_time_energy()
	if not energy.play_timer then
		return
	end
	local time_passed = os.time() - energy.time
	local sec_for_energy = time_menager.from_minutes_to_sec(config.time_for_energy)
	if sec_for_energy > time_passed then
		return false
	end
	local count_energy, remainder = math.modf(time_passed / sec_for_energy)
	if (count_energy + energy.count) >= energy.max_count then
		energy.count = energy.max_count
		energy.play_timer = false
		record.save_data.energy.play_timer = energy.play_timer
	elseif (count_energy + energy.count) < energy.max_count then
		energy.count = count_energy + energy.count
		record.save_data.energy.count = energy.count
		energy.time = os.time() - (remainder * 60)
		record.save_data.energy.time = energy.time
	end
	record.save()
end

function menager_energy.print_timer()
	if not energy.play_timer then
		return false
	end
	local time_passed = os.time() - energy.time
	local sec_for_energy = time_menager.from_minutes_to_sec(config.time_for_energy)
	
	local min, sec = time_menager.from_sec_to_minutes(sec_for_energy - time_passed)
	if min == 0 and sec == 0 then
		check_time_energy()
		return true
	end
	return math.floor(min)..':'..math.floor(sec)
end

local function check_start_timer()
	if record.save_data.energy.timer then
		return
	end
	if check_count_energy() then
		energy.time = os.time()
		record.save_data.energy.time = energy.time
		energy.play_timer = true
		record.save_data.energy.play_timer = energy.play_timer
	else
		energy.time = 0
		record.save_data.energy.time = energy.time
	end
end

local function check_play_timer()
	if energy.play_timer then
		return true
	end
end

function menager_energy.init()
	energy = record.save_data.energy
	energy.max_count = config.max_energy
	
	if check_count_energy() then
		check_time_energy()
	elseif check_play_timer() then
		energy.play_timer = false
		record.save_data.energy.play_timer = energy.play_timer
	end
	return energy.count ..'/'..energy.max_count
end

function menager_energy.check_price_energy()
	if energy.count < config.enegry_price_lvl then
		return false
	end
	return true
end

function menager_energy.take_energy()
	if not menager_energy.check_price_energy() then
		return false
	end
	energy.count = energy.count - config.enegry_price_lvl
	record.save_data.energy = energy
	check_start_timer()
	record.save()
	return true
end

function menager_energy.energy_for_victory()

	energy.count = energy.count + config.enegry_reward_lvl
	record.save_data.energy.count = energy.count
	record.save()
	if check_count_energy() then
		return
	end
	energy.play_timer = true
	record.save_data.energy.play_timer = energy.play_timer
end

return menager_energy