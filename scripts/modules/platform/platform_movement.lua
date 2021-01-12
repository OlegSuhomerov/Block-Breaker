
local app = require('scripts.service.app')
local check_border = require('scripts.modules.platform.check_border')

local platform_movement = {}

local config = app.config
local direction = 1 

local function move(self, direction)
	platform_movement.handle = timer.delay(0.0, true, function()
		
		if not self.move or 
		(check_border.right_edge(self) and direction == math.abs(direction)) or 
		(check_border.left_edge(self) and direction ~= math.abs(direction)) then
			
			timer.cancel(platform_movement.handle)
			return
		end
		
		self.pos.x = self.pos.x + (config.speed_platform * direction)
		go.set_position(self.pos)
		
	end)
	
end

function platform_movement.right(self)
	direction = 1 
	move(self, direction)
end

function platform_movement.left(self)
	direction = -1
	move(self, direction)
end

return platform_movement