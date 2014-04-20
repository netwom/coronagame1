local resources = require('resources')

local egg = {}

function egg.create()
	local eggSheet, eggData = resources.loadEggResources()
	local enemy = display.newSprite( eggSheet, 
	{
		{name = 'fly', start = 1, count = 30, time = 1000},
		{name = 'fire', start = 30, count = 5, loopDirection = 'bounce', loopCount = 1, time = 300},

	}	)
	enemy:play()

	enemy.isFiring = false

	function enemy.startFiring()
		print('start firing')
		enemy.isFiring = true
	end

	function enemy.fireEnded(event)
		if (event.phase == 'ended') then
			enemy:setSequence( 'fly' )
			enemy:play()
			enemy:removeEventListener( 'sprite', enemy.fireEnded )
		end
	end

	function enemy.fire(event)
		if (enemy and enemy.isFiring and enemy.isVisible) then
			enemy:setSequence( 'fire' )
			enemy:play()
			enemy:addEventListener( 'sprite', enemy.fireEnded )
		end
	end



	local delay = math.random(3000, 5000 )
	local tm = timer.performWithDelay( delay, enemy.fire, -1 )

	function enemy:destroy()
		if (self and self.isVisible) then
			self:removeEventListener( 'sprite', enemy.fireEnded )
			self.isActive = false;
			self:removeSelf()
			timer.cancel( tm )
			self = nil
		end
	end

	return enemy
end

return egg