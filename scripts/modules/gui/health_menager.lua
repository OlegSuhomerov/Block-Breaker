
local app = require('scripts.service.app')
local restart = require('scripts.modules.restart')
local loader_scenes = require('scripts.modules.loader_scenes')
local list_scenes = require('scripts.start_modules.list_scenes')

local health_menager = {}

local gui_constants = app.gui_constants
local config = app.config
local game_messages = app.game_messages
local game_components = app.game_components

function health_menager.pos_start_spawn_hp(config)
	local node_game_gui = gui.get_node(game_components.game_gui)
	local node_block_hp = gui.get_node(game_components.block_hp)

	local indent_hp_x = config.size_hearts.x * config.percent_indent_hp
	local center_block_hp = gui.get_position(node_game_gui) + gui.get_position(node_block_hp)
	local start_pos_spawn_hp_x = center_block_hp.x + (gui_constants.size_block_hp.x / 2) - (config.size_hearts.x / 2)
	return vmath.vector3(start_pos_spawn_hp_x, center_block_hp.y, 1), indent_hp_x
end

local function check_hp(self)
	if self.hearts_scene[1] == nil then
		return true
	end
end

function health_menager.minus_hp(self, bonus)
	local node = self.hearts_scene[#self.hearts_scene]
	gui.animate(node, game_messages.scale, 0.0, gui.EASING_LINEAR, 0.2, 0, nil, gui.PLAYBACK_ONCE_FORWARD, function()
		gui.delete_node(node)
	end)
	self.hearts_scene[#self.hearts_scene] = nil
	if check_hp(self) then
		loader_scenes.show_scene(list_scenes.popup_loss)
	elseif not bonus then
		restart.respawn_ball_and_platform()
	end
end

return health_menager