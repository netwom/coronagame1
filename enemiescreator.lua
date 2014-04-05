local COneEnemy = require( 'oneenemy' )

local EnemiesCreator = {}

function EnemiesCreator.create(levelConfig)
	local allEnemies = {}
	for i=1,#levelConfig do
		local bunch = levelConfig[i]
		local bunchEnemies = {}
		for j=1,bunch.num do
			local oneEnemy = COneEnemy.create(-100, 2000, bunch.enemyType) -- set here enemy settings
			allEnemies[#allEnemies + 1] = oneEnemy
			bunchEnemies[#bunchEnemies + 1] = oneEnemy
		end
		timer.performWithDelay( bunch.timeout, function()
				for k=1,#bunchEnemies do
					local enemy = bunchEnemies[k]
					enemy.x = bunch.startPosition[1]
					enemy.y = bunch.startPosition[2]
					enemy:setMoving(bunch.moving, bunch.time)
					timer.performWithDelay( bunch.startTimeout * k, function()
						enemy:startMoving()
						end, 1 )
				end
			end, 1)
	end
	return allEnemies
end

return EnemiesCreator