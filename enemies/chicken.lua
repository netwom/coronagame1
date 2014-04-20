local resources = require('resources')

local chicken = {}

function chicken.create()
	local chickenSheet, chickenData = resources.loadChicken1Resources()
	enemy = display.newSprite( chickenSheet, {name = 'enemy', start = 1, count = 15, time = 600} )
	enemy:play()

	function enemy:destroy()
		if (self and self.isVisible) then
			self.isActive = false;
			self:removeSelf()
		end
	end
	
	return enemy
end



return chicken