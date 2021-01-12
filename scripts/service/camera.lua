
local rendercam = require('rendercam.rendercam')

local camera = {}

function camera.get_pos()
	camera.right_top = rendercam.screen_to_world_2d(rendercam.window.x, rendercam.window.y, false)
	camera.left_bottom = rendercam.screen_to_world_2d(0, 0, false)
	camera.center = rendercam.screen_to_world_2d(rendercam.window.x / 2, rendercam.window.y / 2, false)
	camera.width = camera.right_top.x - camera.left_bottom.x
	camera.hight = camera.right_top.y - camera.left_bottom.y
end

camera.get_pos()

return camera