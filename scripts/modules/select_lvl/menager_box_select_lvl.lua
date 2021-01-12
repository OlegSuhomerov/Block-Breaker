
local menager_box_select_lvl = {}

local app = require('scripts.service.app')
local menager_levels = require('scripts.modules.select_lvl.menager_levels')

local config = app.config
local game_messages = app.game_messages
local game_components = app.game_components

local spawn_pos_button = 0
local buttons = {}

local function size_box_content()
	local content_node = gui.get_node(game_components.content)

	local size_content = config.size_content
	local size_button_y = config.size_button.y
	local indent = config.indent_button_y
	size_content.y = (size_button_y / 2 + indent) * #config.data_chapter - size_button_y / 2

	return content_node, size_content
end

local function start_pos_button_spawn(size_content)
	local start_pos_y = -size_content.y / 2 + config.size_button.y / 2
	return vmath.vector3(0, start_pos_y, 1)
end

local function pos_spawn_button()
	spawn_pos_button.y = spawn_pos_button.y + config.size_button.y / 2 + config.indent_button_y
end

local function get_property_img(node, data)
	gui.set_parent(node, data.node)
	gui.set_texture(node, game_components.atlas_game_level)
	gui.play_flipbook(node, data.img)
	gui.set_adjust_mode(node, gui.ADJUST_FIT)
	gui.set_position(node,config.pos_img)
end

local function get_property_text(node, data)
	gui.set_parent(node, data.node)
	gui.set_position(node, config.pos_text)
end

local function get_text_level(data)
	local of = data.level[1]
	local to = data.level[#data.level]
	if of == to then 
		return 'Level ' .. of
	else
		return 'Levels ' .. of .. '-' .. to
	end
end

local function get_property_text_level(node, data)
	gui.set_parent(node, data.node)
	gui.set_position(node, config.pos_text_lvl)
end	

local function spawn_content(data)
	local node = gui.new_box_node(vmath.vector3(), config.size_img)
	get_property_img(node, data)

	local text_node = gui.new_text_node(vmath.vector3(), data.text)
	get_property_text(text_node, data)

	local text_lvl_node = gui.new_text_node(vmath.vector3(), get_text_level(data))
	get_property_text_level(text_lvl_node, data)
end

local function get_property(node, content, i)
	gui.set_parent(node, content)
	gui.set_adjust_mode(node, gui.ADJUST_STRETCH)
	if menager_levels.check_open_chapter(i) then
		gui.set_color(node, config.color_button)
	else
		buttons[i].close = true
		gui.set_texture(node, game_components.atlas_game_level)
		gui.play_flipbook(node, game_components.bg_chapter_close)
	end
end

function menager_box_select_lvl.spawn_buttons(self)
	local content, size_content = size_box_content()
	gui.set_size(content, size_content)
	spawn_pos_button = start_pos_button_spawn(size_content)
	for i = 1 , #config.data_chapter do

		local node = gui.new_box_node(spawn_pos_button, config.size_button)

		buttons[i] = config.data_chapter[i]
		buttons[i].node = node

		get_property(node, content, i)
		spawn_content(buttons[i])
		
		pos_spawn_button()
	end
end


function menager_box_select_lvl.touch_button(self, action_id, action)
	if action_id == game_messages.touch then
		for k in pairs(buttons) do
			if gui.pick_node(buttons[k].node, action.x, action.y) and action.released and not buttons[k].close then
				if menager_levels.select_level(k) then
					return true
				end
			end
		end
	end
end

return menager_box_select_lvl