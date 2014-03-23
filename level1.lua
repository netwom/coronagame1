local collisions = require( 'collisions' )
local COneEnemy = require( 'oneenemy' )

local lvl = display.newGroup( )
local enemies = {}
local timerId
local curve
local curveRoundTime = 2000

local checkEnemiesTimer

local enemyWeaponTimer

local levelConfig = {

--moving = {{x = 300, dY = -100, fr = 60}, {x = 550, dY = 100, fr = 60}, {x = 300, dY = 100, fr = 60}, {x = 50, dY = -100, fr = 60}, {pause = 1000} }
						{startX = 50, startY = 100, health = 5},
						{startX = 160, startY = 40, health = 5},
						{startX = 220, startY = -20, health = 5},
						{startX = 280, startY = -80, health = 5},
						{startX = 340, startY = -120, health = 5},

						{startX = 200, startY = -190, health = 5, moving = {{x = 300, dY = -100, fr = 60}, {x = 550, dY = 100, fr = 60}, {x = 300, dY = 100, fr = 60}, {x = 50, dY = -100, fr = 60}, {pause = 1000} }  },
						{startX = 400, startY = -290, health = 5, moving = {{x = 300, dY = -100, fr = 60}, {x = 550, dY = 100, fr = 60}, {x = 300, dY = 100, fr = 60}, {x = 50, dY = -100, fr = 60}, {pause = 1000} }  },
					}



function lvl.onEnterFrame(event)
	for i=1,#enemies do -- activate enemies near to screen
		if (enemies[i].isActive == false and enemies[i].y and enemies[i].y > -30) then
			enemies[i].isActive = true
			enemies[i].isReadyToMove = true
		end
		if (enemies[i].isActive and enemies[i].isReadyToMove) then
			local oneEnemy = enemies[i]
			if (levelConfig[i] and levelConfig[i].moving) then
				local allMovings = levelConfig[i].moving
				if (oneEnemy.movingStep == nil) then
					oneEnemy.movingStep = 0
				end
				oneEnemy.movingStep = oneEnemy.movingStep + 1
				if (oneEnemy.movingStep > #allMovings) then
					oneEnemy.movingStep = 1
				end
				-- tween
				local curMove = allMovings[oneEnemy.movingStep]
				if (curMove.pause) then
					oneEnemy.isReadyToMove = false
					timer.performWithDelay( curMove.pause, function() oneEnemy.isReadyToMove = true  end, 1 )
				else
					oneEnemy.isReadyToMove = false

					oneEnemy.dx = (curMove.x - oneEnemy.x) / curMove.fr
					oneEnemy.dy = curMove.dY / curMove.fr

					oneEnemy.isMoving = true
				end

				
				
			end
		end

		if (enemies[i].isActive and enemies[i].isMoving) then
			local allMovings = levelConfig[i].moving
			local oneEnemy = enemies[i]
			local curMove = allMovings[oneEnemy.movingStep]
			oneEnemy.x = oneEnemy.x + oneEnemy.dx
			oneEnemy.y = oneEnemy.y + oneEnemy.dy
			if (math.abs( oneEnemy.x - curMove.x ) < math.abs(oneEnemy.dx) ) then
				oneEnemy.isReadyToMove = true
				oneEnemy.isMoving = false
			end

		end
	end
	
end

function lvl.init()
	print('level init')
	
end

function lvl.start()
	print('level start')
	local enterFrameHandler = lvl.onEnterFrame
	Runtime:addEventListener( "enterFrame", enterFrameHandler )
	
end

function lvl.destroy()
	print('level destroy')
	for i=1,#enemies do
		local oneEnemy = enemies[i]
		if (oneEnemy.isVisible) then
			oneEnemy:removeSelf()
		end
		enemies[i] = nil
	end
	enemies = {}

	local enterFrameHandler = lvl.onEnterFrame
	Runtime:removeEventListener( "enterFrame", enterFrameHandler )
end

function lvl.getEnemies()

	for i=1,#levelConfig do
		local itemConfig = levelConfig[i]
		local tmpRadius = 50
		local oneEnemy = COneEnemy.create(itemConfig.startX, itemConfig.startY, tmpRadius)
		oneEnemy.health = itemConfig.health
		oneEnemy.isActive = false
		physics.addBody( oneEnemy, 'static', { radius=tmpRadius, filter=collisions.enemyFilter } )
		table.insert( enemies, oneEnemy )
	end

	return enemies
end

return lvl