
local monarch = require('monarch.monarch')

local loader_scenes = {}

local options = {sequential = true}

function loader_scenes.show_scene(scene_id,data)
	monarch.replace(scene_id, options, data)
end

function loader_scenes.hide_scene(scene_id)
	monarch.hide(scene_id)
end

return loader_scenes