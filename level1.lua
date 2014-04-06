local collisions = require( 'collisions' )
local movings = require('movings')
local EnemiesCreator = require('enemiescreator')

local lvl = display.newGroup( )

local levelConfig = {
{timeout = 1100, num = 3, startPosition = {800, 80}, enemyType = 1, moving = movings.zigzagTLtoDR, startTimeout = 500, time = 10000 }, 
{timeout = 5000, num = 3, startPosition = {80, -50}, enemyType = 2, moving = movings.zigzagTtoD, startTimeout = 500, time = 8000 }, 
{timeout = 9000, num = 3, startPosition = {575, -120}, enemyType = 1, moving = movings.roundD, startTimeout = 500, time = 8000 }, 
{timeout = 14350, num = 2, startPosition = {835, 40}, enemyType = 2, moving = movings.zigzagTRtoTL, startTimeout = 500, time = 12000 }, 
{timeout = 19850, num = 2, startPosition = {545, -125}, enemyType = 2, moving = movings.turnTLtoDR, startTimeout = 500, time = 5000 }, 
{timeout = 25950, num = 3, startPosition = {550, -140}, enemyType = 1, moving = movings.roundTRtoDR, startTimeout = 500, time = 8000 }, 
{timeout = 31000, num = 2, startPosition = {570, -150}, enemyType = 2, moving = movings.eightTRtoDL, startTimeout = 500, time = 8000 }, 
{timeout = 35900, num = 2, startPosition = {800, 80}, enemyType = 1, moving = movings.zigzagTLtoDR, startTimeout = 500, time = 10000 }, 
{timeout = 39150, num = 2, startPosition = {80, -50}, enemyType = 1, moving = movings.zigzagTtoD, startTimeout = 500, time = 8000 }, 

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