local collisions = require( 'collisions' )
local movings = require('movings')
local EnemiesCreator = require('enemiescreator')

local lvl = display.newGroup( )

local levelConfig = {
	{timeout = 500, num = 3, startPosition = {570, -150}, enemyType = 2, moving = movings.eightTRtoDL, startTimeout = 300, time = 4000 }, 
{timeout = 5400, num = 3, startPosition = {95, -125}, enemyType = 2, moving = movings.invertX(movings.turnTLtoDR), startTimeout = 300, time = 4000 }, 
{timeout = 11250, num = 2, startPosition = {70, -150}, enemyType = 2, moving = movings.invertX(movings.eightTRtoDL), startTimeout = 300, time = 4000 }, 
{timeout = 13850, num = 2, startPosition = {-160, 80}, enemyType = 1, moving = movings.invertX(movings.zigzagTLtoDR), startTimeout = 300, time = 5000 }, 
{timeout = 19550, num = 2, startPosition = {95, -125}, enemyType = 1, moving = movings.invertX(movings.turnTLtoDR), startTimeout = 300, time = 4000 }, 
{timeout = 26100, num = 3, startPosition = {-160, 80}, enemyType = 1, moving = movings.invertX(movings.zigzagTLtoDR), startTimeout = 300, time = 5000 }, 
{timeout = 31200, num = 2, startPosition = {-160, 80}, enemyType = 2, moving = movings.invertX(movings.zigzagTLtoDR), startTimeout = 300, time = 5000 }, 
{timeout = 34700, num = 3, startPosition = {-160, 80}, enemyType = 2, moving = movings.invertX(movings.zigzagTLtoDR), startTimeout = 300, time = 5000 }, 
{timeout = 38850, num = 2, startPosition = {95, -125}, enemyType = 2, moving = movings.invertX(movings.turnTLtoDR), startTimeout = 300, time = 4000 }, 

}





function lvl.init()
	
	
end

function lvl.start()
	
	
end

function lvl.destroy()
	
end

function lvl.getEnemies()
	local allEnemies = EnemiesCreator.create(levelConfig)	
	return allEnemies
	
end

return lvl