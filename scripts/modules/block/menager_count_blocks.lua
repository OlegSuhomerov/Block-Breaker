
local app = require('scripts.service.app')
local menager_levels = require('scripts.modules.select_lvl.menager_levels')
local menager_energy = require('scripts.modules.menager_energy')
local loader_scenes = require('scripts.modules.loader_scenes')
local list_scenes = require('scripts.start_modules.list_scenes')

local menager_count_blocks = {}

local config = app.config
local game_components = app.game_components
local game_messages = app.game_messages

menager_count_blocks.list = {}

local list = menager_count_blocks.list
local count
local percent_in_block
local percent_passed 

local function check_empty()
	for k,v in pairs(list) do
		if not v.settings.invulnerability then
			return false
		end
	end
	return true
end

local function level_completed()
	menager_energy.energy_for_victory()
	menager_levels.open_level()
	loader_scenes.show_scene(list_scenes.popup_victory)
end

local function percentage_passed()
	percent_passed = percent_passed + percent_in_block
	msg.post(game_components.game_gui, game_messages.change_progress, {percent = percent_passed})
end

function menager_count_blocks.block_delete(self)
	go.delete(list[self.id].url)
	percentage_passed()
	list[self.id] = nil
	if check_empty() then 
		level_completed()
	end
end

function menager_count_blocks.delete_all_blocks()
	for k in pairs(list) do
		go.delete(list[k].url)
		list[k] = nil
	end
	return true
end

local function calculation_blocks_in_percent(count)
	percent_in_block = 100 / count
end

function menager_count_blocks.init()
	count = 0
	percent_in_block = 0
	percent_passed = 0
	for k in pairs(list) do
		if not list[k].settings.invulnerability then
			count = count + 1
		end
	end
	msg.post(game_components.game_gui, game_messages.change_progress, {percent = percent_passed})
	calculation_blocks_in_percent(count)
end

function menager_count_blocks.get_percent()
	return percent_passed
end

return menager_count_blocks