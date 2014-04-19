local collisions = require('collisions')

local COneEnemy = {}

function COneEnemy.create(startX, startY, type)
	local enemy
	--enemy = display.newRect( startX - 10, startY - 40, 20, 80 )
	enemy = display.newImage( 'img/chicken.png')
	enemy.x = -100
	enemy.y = -100
	local stepTime = 0

	if (type == 1) then
		enemy:setFillColor( 1, 0, 0 )
	elseif(type == 2) then
		enemy:setFillColor( 0, 1, 0 )
	elseif(type == 3) then
		enemy:setFillColor( 0, 0, 1 )
	elseif(type == 4) then
		enemy:setFillColor( 1, 1, 0 )
	elseif(type == 5) then
		enemy:setFillColor( 1, 0, 1 )
	elseif(type == 6) then
		enemy:setFillColor( 0, 1, 1 )
	end

	function enemy:setMoving(moving, time)
		self.moving = {x = {}, y = {}, r ={}}

		for i=1,#moving.x do			
			self.moving.x[i] = moving.x[i] + self.x
			self.moving.y[i] = moving.y[i] + self.y
			self.moving.r[i] = moving.r[i]
		end

		
		self.movingStep = 0
		
		stepTime = time / #self.moving.x
	end

	function enemy:startMoving()
		self.movingStep = self.movingStep + 1
		if (self.moving.x[self.movingStep]) then
			transition.to( self, {
				x = self.moving.x[self.movingStep], 
				y = self.moving.y[self.movingStep], 
				rotation = self.moving.r[self.movingStep],
				time = stepTime, 
				onComplete = self.startMoving} )
		else
			if (self and self.isVisible) then
				self:removeSelf()
			end
		end
		
	end

	function enemy:destroy()
		self.isActive = false;
		self:removeSelf()
	end

	enemy.health = 5
	physics.addBody( enemy, 'static', { filter=collisions.enemyFilter } )

	return enemy
end

return COneEnemy