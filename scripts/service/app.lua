

local app = {}

app.loader_scenes = require('scripts.modules.loader_scenes')
app.list_scenes = require('scripts.start_modules.list_scenes')
app.game_messages = require('scripts.start_modules.game_messages')
app.game_components = require('scripts.start_modules.game_components')
app.config = require('scripts.start_modules.config')
app.camera = require('scripts.service.camera')
app.gui_constants = require('scripts.start_modules.gui_constants')
app.go_constants = require('scripts.start_modules.go_constants')

return app