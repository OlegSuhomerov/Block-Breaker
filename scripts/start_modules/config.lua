
game_components = require('scripts.start_modules.game_components')

local config = {}

config.percent_indent_wall_up = 0.1
config.percent_margin_edge_board = 0.01
config.start_value_progress = 0

--bonus
config.speed_bonus = 6
config.bonus_speed_up = 1.3
config.bonus_speed_down = 1.3
config.timer_speed_bonus = 5
config.start_directions_bonus_ball = vmath.vector3(-680, 1600, 1)
config.bonus_speed_platform = 0.5
config.bonus_damage_ball = 4
config.time_fire_ball = 6

--enegry
config.max_energy = 30
config.time_for_energy = 20
config.enegry_price_lvl = 3
config.enegry_reward_lvl = 5

--button chapter in select level
config.size_content = vmath.vector3(360, 1000, 1)
config.size_button = vmath.vector3(360, 200, 1)
config.indent_button_y = 150
config.color_button = vmath.vector3(0.2, 0.47, 1)
config.size_img = vmath.vector3(100, 100 ,1)
config.pos_img = vmath.vector3(-100, 0, 0)
config.pos_text = vmath.vector3(50, 35, 0)
config.pos_text_lvl = vmath.vector3(50, -35, 0)

--ball
config.speed_ball = 6
config.speed_multiplier_ball = 4
config.start_factor_speed_ball = 1
config.factor_speed_per_block = 0.02
config.start_speed_ball = 1800
config.max_factor_speed_ball = 1.4
config.slow_speed = 30
config.acceleration_ball = 5

--platform
config.speed_platform = 4
config.size_platform = vmath.vector3(125, 36, 1)
config.indent_platform = 1
config.indent_ball = 2

--block
config.block_damage = 1
config.id_start_animate_block = 1
config.id_broken_animate_block = 2
config.size_block = vmath.vector3(38, 12, 1)

--health
config.count_health = 3
config.size_hearts = vmath.vector3(35, 30, 0)
config.percent_indent_hp = 0.1

--level
config.start_level = 1
config.start_chapter = 1
config.select_lvl = 0
config.select_chapter = 0

config.data_chapter = {
	[1] = {img = game_components.chapter_1, level = {1,2,3}, text = 'Chapter 1'},
	[2] = {img = game_components.chapter_2, level = {4,5,6}, text = 'Chapter 2'},
	[3] = {img = game_components.chapter_3, level = {7,8,9}, text = 'Chapter 3'},
	[4] = {img = game_components.chapter_4, level = {10}, text = 'Chapter 4'}
}

config.data_levels = {
	[1] = {level = game_components.level_1, group_lvl = 1},
	[2] = {level = game_components.level_2, group_lvl = 1},
	[3] = {level = game_components.level_3, group_lvl = 1},
	[4] = {level = game_components.level_4, group_lvl = 2},
	[5] = {level = game_components.level_5, group_lvl = 2},
	[6] = {level = game_components.level_6, group_lvl = 2},
	[7] = {level = game_components.level_7, group_lvl = 3},
	[8] = {level = game_components.level_8, group_lvl = 3},
	[9] = {level = game_components.level_9, group_lvl = 3},
	[10] = {level=game_components.level_10, group_lvl = 4}
}

config.status_close = 1
config.status_open = 2
config.status_passed = 3

config.start_save_chapter = {
	[1] = {passed = false},
	[2] = {passed = false},
	[3] = {passed = false},
	[4] = {passed = false}
}

config.start_save_lvl = {
	[1] = {id_status = 1},
	[2] = {id_status = 1},
	[3] = {id_status = 1},
	[4] = {id_status = 1},
	[5] = {id_status = 1},
	[6] = {id_status = 1},
	[7] = {id_status = 1},
	[8] = {id_status = 1},
	[9] = {id_status = 1},
	[10] = {id_status = 1}
}

config.sprite_blocks = {
	[1] = {"yellow", "broken_yellow", color = vmath.vector4(1, 0.86, 0, 1)},
	[2] = {"orange", "broken_orange", color = vmath.vector4(0.96, 0.57, 0.11, 1)},
	[3] = {"red", "broken_red", color = vmath.vector4(0.92, 0.1, 0.14, 1)},
	[4] = {"bomb", "broken_bomb", color = vmath.vector4(0.45, 0.29, 0.12, 1)},
	[5] = {"chain_bomb", "broken_chain_bomb", color = vmath.vector4(0.45, 0.29, 0.12, 1)},
	[6] = {"vertical_bomb", "broken_vertical_bomb", color = vmath.vector4(0.45, 0.29, 0.12, 1)},
	[7] = {"horizontal_bomb", "broken_horizontal_bomb", color = vmath.vector4(0.45, 0.29, 0.12, 1)},
	[8] = {"speed_ball_up", "broken_speed_ball_up", color = vmath.vector4(0.54, 0.77, 0.24, 1)},
	[9] = {"gray"},
	[10] = {"speed_ball_down", "broken_speed_ball_down", color = vmath.vector4(0.54, 0.77, 0.24, 1)},
	[11] = {"add_ball", "broken_add_ball", color = vmath.vector4(0.54, 0.77, 0.24, 1)},
	[12] = {"black_heart", "broken_black_heart", color = vmath.vector4(0.54, 0.77, 0.24, 1)},
	[13] = {"add_heart", "broken_add_heart", color = vmath.vector4(0.54, 0.77, 0.24, 1)},
	[14] = {"platform_speed_up", "broken_platform_speed_up", color = vmath.vector4(0.54, 0.77, 0.24, 1)},
	[15] = {"platform_speed_down", "broken_platform_speed_down", color = vmath.vector4(0.54, 0.77, 0.24, 1)},
	[16] = {"fire_ball", "broken_fire_ball", color = vmath.vector4(0, 0.35, 0.67, 1)}
}

config.object_bonus = {
	[5] = {sprite = "boost_speed_ball_up"},
	[6] = {sprite = "boost_speed_ball_down"},
	[7] = {sprite = "bonus_add_ball"},
	[8] = {sprite = "bonus_black_heart"},
	[9] = {sprite = "bonus_heart"},
	[10] = {sprite = "bonus_platform_speed_up"},
	[11] = {sprite = "bonus_platform_speed_down"},
	[12] = {sprite = "bonus_fire_ball"}
}

return config