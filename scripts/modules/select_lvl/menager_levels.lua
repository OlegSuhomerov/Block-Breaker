
local record = require('scripts.service.record')
local app = require('scripts.service.app')

local menager_levels = {}

local config = app.config

function menager_levels.check_open_chapter(i)
	if record.save_data.chapters[i].passed == true then
		return true
	end
	for k,v in pairs(config.data_chapter[i].level) do
		if record.save_data.levels[v].id_status == config.status_open
		or record.save_data.levels[v].id_status == config.status_passed then
			return true
		end
	end
end

function menager_levels.select_level(k)
	if record.save_data.chapters[k].passed == true then
		local num_first_level_in_chapter = config.data_chapter[k].level[1]
		config.select_lvl = config.data_chapter[k].level[1]
		config.select_chapter = k
		return true
	end
	for i = 1, #config.data_chapter[k].level do
		local num_level = config.data_chapter[k].level[i]
		if record.save_data.levels[num_level].id_status == config.status_open then
			config.select_lvl = num_level

			config.select_chapter = k
			return true
		end
	end
end

local function check_level_empty(level)
	if config.data_levels[level] ~= nil then
		return false
	end
	return true
end

local function check_chapter_level(level)
	if config.data_levels[level].group_lvl ~= config.select_chapter then
		return true
	end
end

function menager_levels.next_level()

	local next_level = config.select_lvl + 1
	if check_level_empty(next_level) then
		config.select_lvl = config.start_level
	else
		config.select_lvl = config.select_lvl + 1
	end
	if check_chapter_level(config.select_lvl) then
		config.select_chapter = config.data_levels[config.select_lvl].group_lvl
	end
	return true
end

local function final_lvl_in_chapter(num_level, next_level, num_chapter)
	for k,v in pairs(config.data_chapter[num_chapter].level) do
		if v == num_level and config.data_chapter[num_chapter].level[k + 1] == nil then
			return true
		end
	end
end

local function check_open_lvl(num_level)
	if record.save_data.levels[num_level].id_status == config.status_open then
		return true
	end
end

local function check_finaly_lvl(next_level)
	if record.save_data.levels[next_level] ~= nil then
		return true
	end
end

function menager_levels.open_level()
	local num_level = config.select_lvl
	local next_level = num_level + 1
	local num_chapter = config.select_chapter
	
	if not check_open_lvl(num_level) then
		return
	end
	record.save_data.levels[num_level].id_status = config.status_passed
	if check_finaly_lvl(next_level) then
		record.save_data.levels[next_level].id_status = config.status_open
	end
	if final_lvl_in_chapter(num_level, next_level, num_chapter) then
		record.save_data.chapters[num_chapter].passed = true
	end
	record.save()
end

return menager_levels