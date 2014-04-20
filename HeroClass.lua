local resources = require('resources')
local collisions = require('collisions')
local timer = require('timer')
local weapon = require('weapon')

local HClass = display.newGroup( )

local hero
local moveToX, moveToY
local doMove = false
local speed = 10
local faultDistance = 5
local weaponDelay = 200
local timerId
local weaponInterval = 40
HClass.isFiring = false
HClass.weaponNum = 1

local levelSpriteSheet, explosionSpriteSheet

local function onLocalCollision(self, event)
	if(event.other.isEnemyWeapon) then
		hero:setSequence( 'bited' )
		hero:play()

		function hero.spriteEvent(event)
			if (event.phase == 'ended' and event.target.sequence == 'bited') then
				hero:setSequence( 'fly' )
				hero:play()
				hero:removeEventListener( 'sprite', hero.spriteEvent )
			end
		end

		hero:addEventListener( 'sprite', hero.spriteEvent )

		event.other:removeSelf()
	end
end

function HClass.setLevelSprite(sprite)
	levelSpriteSheet = sprite
end

function HClass.setExplosionSprite(sprite)
	explosionSpriteSheet = sprite
	print('set')
end

function HClass:touch(event)
	if (event.phase == 'began' or event.phase == 'moved') then
		doMove = true
		moveToX = event.x
		moveToY = event.y
	end
end

function HClass:enterFrame(event)
	if (doMove and hero.x and hero.y) then
		local deltaX = moveToX - hero.x
		local deltaY = moveToY - hero.y

		if (deltaX > 0 and hero.sequence ~= 'flyRight' and hero.sequence ~= 'bited') then
			hero:setSequence('flyRight')
			hero:play()
		elseif (deltaX < 0 and hero.sequence ~= 'flyLeft' and hero.sequence ~= 'bited') then
			hero:setSequence('flyLeft')
			hero:play()
		end

		if (deltaX ~= 0 or deltaY ~= 0) then
			if (math.sqrt( (moveToX - hero.x) * (moveToX - hero.x) + (moveToY - hero.y) * (moveToY - hero.y) ) < faultDistance) then
				doMove = false
				hero:setSequence('fly')
				hero:play()
			else 
				--local toMoveX = (deltaX / ( math.abs(deltaX) + math.abs(deltaY))) * speed
				--local toMoveY = (deltaY / ( math.abs(deltaX) + math.abs(deltaY))) * speed
				local toMoveX = deltaX / 6
				local toMoveY = deltaY / 6


				hero.x = math.round( hero.x + toMoveX ) 
				hero.y = math.round( hero.y + toMoveY )
				--if (hero.x == moveToX and hero.y == moveToY) then
				--	doMove = false
				
				--end
			end

			
			
		end
	end
end

function HClass:timer(event)
	self:fire()
end

function HClass.fire()
	if (HClass.isFiring) then
		local sX = hero.x - ((HClass.weaponNum - 1) * weaponInterval) / 2
		for i=1,HClass.weaponNum do
			local rocket = weapon.createRocket()

			local dX = (i - 1) * weaponInterval

			rocket.x = sX + dX
			rocket.y = hero.y
			local event = {name="rocketCreated", item=rocket}
			hero:dispatchEvent( event )	
		end

		
	end
end



function HClass.createHero()
	--hero = display.newRect( 0, 0, 50, 150 )
	--width = 127, height = 98
	--hero = display.newImageRect(levelSpriteSheet, 1, 127, 98 )

	local pigSheet, pigData = resources.loadPigResources()
	hero = display.newSprite( pigSheet, {
		{name = 'fly', start = 1, count = 15, time = 500},
		{name = 'flyLeft', start = 21, count = 5, loopCount = 1, time = 300, time=300},
		{name = 'flyRight', start = 16, count = 5, loopCount = 1, time = 300, time=300},
		{name = 'bited', start = 27, count = 2, time = 150, loopDirection = 'bounce', loopCount = 1}
	}
	)
	hero:setSequence( 'fly' )
	hero:play()

	--hero = display.newImage('img/hog.png' )
	physics.addBody( hero, 'static', {filter = collisions.heroFilter } )
	Runtime:addEventListener( "touch", HClass )
	Runtime:addEventListener( "enterFrame", HClass )
	timerId = timer.performWithDelay( weaponDelay, HClass, -1 )
	weapon.setExplosionSpriteSheet(explosionSpriteSheet)
	weapon.init(levelSpriteSheet)
	hero.preCollision = onLocalCollision
	hero:addEventListener( 'preCollision', hero )
	return hero
end

function HClass.destroyHero()
	hero = nil
	moveToX = nil
	moveToY = nil
	doMove = nil
	Runtime:removeEventListener( "touch", HClass )
	Runtime:removeEventListener( "enterFrame", HClass )
	weapon.destroy()
	timer.cancel( timerId )
end



return HClass