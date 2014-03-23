local physics = require( 'physics' )
local collisions = require( 'collisions' )

local CEnemies = {}

local group
local allEnemies = {}
local currentLevelObject
local checkEnemiesDestroyedTimer
local levelSpriteSheet
local GLOBAL_ENEMY_SPEED = 1


function CEnemies.enterFrame(event)
	for i=1,#allEnemies do
		local oneEnemy = allEnemies[i]
		if (oneEnemy ~= nil and oneEnemy.isVisible) then
			oneEnemy.y = oneEnemy.y + GLOBAL_ENEMY_SPEED
		end
		if (oneEnemy ~= nil and oneEnemy.isVisible and oneEnemy.y > 1236 ) then
			oneEnemy:destroy()
		end
	end

end

local function onLocalCollision(self, event)
	if (event.other.isWeapon) then
		if (self.y > 0) then
			self.health = self.health - event.other.strength
			if (self.health <= 0) then
				self:destroy()
				--self.isActive = false
				--self:removeSelf()
			end
		end
		--event.other:removeSelf()	
		event.other:explode()
	end
	return true
end

function CEnemies.enemyFire(event)
	-- event.fireX
	-- event.fireY
	print('enemy fire')
	local enemyFire = display.newImageRect( levelSpriteSheet, 2, 13, 35 )
	physics.addBody( enemyFire, {filter=collisions.enemyWeaponFilter} )
	enemyFire.rotation = 180
	enemyFire.x = event.fireX
	enemyFire.y = event.fireY
	enemyFire.isEnemyWeapon = true
	local eventFire = {name = 'enemyFireAdded', item = enemyFire}
	enemyFire:setLinearVelocity( 0, event.weaponSpeed )
	group:dispatchEvent( eventFire )
end

function CEnemies.createEnemies(levelId)
	group = display.newGroup()

	currentLevelObject = require('level' .. levelId)
	currentLevelObject.init()
	local enemies = currentLevelObject.getEnemies()

	for k, enemy in pairs(enemies) do
		group:insert(enemy)
		table.insert( allEnemies, enemy )
		enemy.preCollision = onLocalCollision
		enemy:addEventListener( "preCollision", enemy )
	end
	currentLevelObject.start()

	function allEnemiesDestroyed()
		local destroyed = true
		for i=1,#enemies do
			if (enemies[i].isVisible) then
				destroyed = false
			end
		end
		
		if (destroyed) then
			local event = {name = 'allEnemiesDestroyed'}
			if (group) then
				group:dispatchEvent( event )
			end
		end
	end

	checkEnemiesDestroyedTimer = timer.performWithDelay( 1000, allEnemiesDestroyed, -1 )
	local enemyFire = CEnemies.enemyFire
	currentLevelObject:addEventListener( 'enemyFire', enemyFire )

	local enterFrameHandler = CEnemies.enterFrame
	Runtime:addEventListener( "enterFrame", enterFrameHandler )

	return group
end



function CEnemies.init(sheet)
	levelSpriteSheet = sheet
	allEnemies = {}
end

function CEnemies.destroy()
	local onCollision = CEnemies.collision
	Runtime:removeEventListener( "preCollision", onCollision )
	if (currentLevelObject) then
		currentLevelObject.destroy()
		for k, v in pairs(allEnemies) do
			if (v.isVisible) then
				v:removeSelf( )
			end
			allEnemies[k] = nil
		end
	end
	if (checkEnemiesDestroyedTimer) then
		timer.cancel( checkEnemiesDestroyedTimer )
		checkEnemiesDestroyedTimer = nil
	end
	if (currentLevelObject) then
		local enemyFire = CEnemies.enemyFire
		currentLevelObject:removeEventListener( 'enemyFire', enemyFire )
	end
end

return CEnemies