local collisions = require('collisions')
local physics = require('physics')

local CWeapon = {}
local weaponSpeed = 1000
local timerId
local weaponSheet

local allWeapons = {}
local explosionSpriteSheet

function CWeapon.setExplosionSpriteSheet(sheet)
	explosionSpriteSheet = sheet
end

function CWeapon.explode(x, y)
	local timeout = 500
	local sequenceData = {
 
	  { name = "normalRun",  --name of animation sequence
	    start = 1,  --starting frame index
	    count = 40,  --total number of frames to animate consecutively before stopping or looping
	    time = timeout,  --optional, in milliseconds; if not supplied, the sprite is frame-based
	    loopCount = 1,  --optional. 0 (default) repeats forever; a positive integer specifies the number of loops
	    loopDirection = "forward"  --optional, either "forward" (default) or "bounce" which will play forward then backwards through the sequence of frames
	  }  --if defining more sequences, place a comma here and proceed to the next sequence sub-table
	 
	}
	local explosion = display.newSprite(explosionSpriteSheet, sequenceData)
	explosion.x = x
	explosion.y = y
	explosion:play()
	function removeObject()
		explosion:removeSelf()
	end
	timerId = timer.performWithDelay( timeout, removeObject, 1)
end

function CWeapon.createRocket()
	--local weapon = display.newRect( 0, 0, 20, 50 )
	local weapon = display.newGroup()
	local weaponItem = display.newImageRect(weaponSheet, 2, 13, 35 )
	weapon:insert(weaponItem)
	weapon.strength = 1
	weapon.isWeapon = true
	physics.addBody( weapon, { filter = collisions.weaponFilter} )
	weapon:setLinearVelocity(0, -weaponSpeed)
	table.insert( allWeapons, weapon )

	function weapon:explode()
		CWeapon.explode(self.x, self.y)
		self:removeSelf()
	end

	return weapon
end

function CWeapon.gc(event)
	for k, oneWeapon in pairs(allWeapons) do
		if (oneWeapon and oneWeapon.y and oneWeapon.y < 0) then
			oneWeapon:removeSelf( )
			allWeapons[k] = nil
		end
	end
end

function CWeapon.init(sheet)
	weaponSheet = sheet
	allWeapons = {}
	local garbageCollector = CWeapon.gc
	timerId = timer.performWithDelay( 5000, garbageCollector, -1 )
end

function CWeapon.destroy()
	allWeapons = {}
	timer.cancel( timerId )
end

return CWeapon