local collisions = require('collisions')
local physics = require('physics')
local levelLayers = require( 'levellayers' )

local CWeapon = {}
local weaponSpeed = 2500
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
	local enemiesLayer, heroLayer, weaponLayer, explosionLayer, backgroundLayer = levelLayers.get()
	local explosion = display.newSprite(explosionSpriteSheet, sequenceData)
	explosionLayer:insert(explosion)
	explosion.x = x
	explosion.y = y
	explosion:play()
	function removeObject()
		if (explosion and explosion.isVisible) then
			explosion:removeSelf()
		end
	end
	timerId = timer.performWithDelay( timeout, removeObject, 1)
end

function CWeapon.createRocket(scale)
	scale = scale or 0.5
	--local weapon = display.newRect( 0, 0, 20, 50 )
	local weapon = display.newGroup()
	--local weaponItem = display.newImageRect(weaponSheet, 2, 13, 35 )

	local weaponItem = display.newImage('img/bullet.png' )

	weapon:insert(weaponItem)
	weapon.strength = 2
	weapon.isWeapon = true

	weapon.xScale = scale
	weapon.yScale = scale

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