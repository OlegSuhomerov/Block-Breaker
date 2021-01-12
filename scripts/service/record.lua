
local defsave = require("defsave.defsave")
local app = require('scripts.service.app')

local record = {}

local config = app.config
record.save_data = {}

local function delete_record()
	defsave.set("save_data", "levels", nil)
	defsave.set("save_data", "chapters", nil)
	defsave.set("save_data", "energy", nil)
	defsave.save("save_data")
end

function record.save()
	defsave.set("save_data", "levels", record.save_data.levels)
	defsave.set("save_data", "chapters", record.save_data.chapters)
	defsave.set("save_data", "energy", record.save_data.energy)
	defsave.save("save_data")
end

local function create_data()
	record.save_data.levels = config.start_save_lvl
	record.save_data.levels[config.start_level].id_status = config.status_open
	record.save_data.energy = {count = config.max_energy, time = 0, play_timer = false}
	record.save_data.chapters = config.start_save_chapter
	record.save()
end

function record.load_save()

	defsave.appname = "Block Breaker"
	defsave.load("save_data")

	if defsave.get("save_data","levels") == nil then
		create_data()
		return true
	end
	record.save_data.levels = defsave.get("save_data","levels")
	record.save_data.energy = defsave.get("save_data","energy")
	record.save_data.chapters = defsave.get("save_data","chapters")
end

function record.check()
	

end

function record.show()


end


return record