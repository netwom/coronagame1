local collisions = require( 'collisions' )
local movings = require('movings')
local EnemiesCreator = require('enemiescreator')

local lvl = display.newGroup( )

local levelConfig = {
{timeout = 83.720930232558, num = 4, startPosition = {575, -120}, enemyType = 1, moving = movings.roundD, startTimeout = 500, time = 8000 }, 
{timeout = 2762.7906976744, num = 4, startPosition = {-195, 40}, enemyType = 6, moving = movings.invertX(movings.zigzagTRtoTL), startTimeout = 500, time = 12000 }, 
{timeout = 6223.2558139535, num = 6, startPosition = {-160, 80}, enemyType = 5, moving = movings.invertX(movings.zigzagTLtoDR), startTimeout = 500, time = 10000 }, 
{timeout = 7786.0465116279, num = 3, startPosition = {545, -125}, enemyType = 1, moving = movings.turnTLtoDR, startTimeout = 500, time = 5000 }, 
{timeout = 11748.837209302, num = 5, startPosition = {800, 80}, enemyType = 4, moving = movings.zigzagTLtoDR, startTimeout = 500, time = 10000 }, 
{timeout = 13897.674418605, num = 6, startPosition = {-160, 80}, enemyType = 3, moving = movings.invertX(movings.zigzagTLtoDR), startTimeout = 500, time = 10000 }, 
{timeout = 17134.88372093, num = 5, startPosition = {570, -150}, enemyType = 4, moving = movings.eightTRtoDL, startTimeout = 400, time = 8000 }, 
{timeout = 19702.325581395, num = 6, startPosition = {-160, 80}, enemyType = 1, moving = movings.invertX(movings.zigzagTLtoDR), startTimeout = 500, time = 10000 }, 
{timeout = 22102.325581395, num = 3, startPosition = {545, -125}, enemyType = 6, moving = movings.turnTLtoDR, startTimeout = 500, time = 5000 }, 
{timeout = 24669.76744186, num = 4, startPosition = {70, -150}, enemyType = 5, moving = movings.invertX(movings.eightTRtoDL), startTimeout = 400, time = 8000 }, 
{timeout = 27237.209302326, num = 6, startPosition = {545, -125}, enemyType = 5, moving = movings.turnTLtoDR, startTimeout = 500, time = 5000 }, 
{timeout = 30502.325581395, num = 3, startPosition = {575, -120}, enemyType = 4, moving = movings.roundD, startTimeout = 500, time = 8000 }, 
{timeout = 33181.395348837, num = 5, startPosition = {545, -125}, enemyType = 3, moving = movings.turnTLtoDR, startTimeout = 500, time = 5000 }, 
{timeout = 36139.534883721, num = 6, startPosition = {570, -150}, enemyType = 3, moving = movings.eightTRtoDL, startTimeout = 400, time = 8000 }, 
{timeout = 38595.348837209, num = 5, startPosition = {545, -125}, enemyType = 4, moving = movings.turnTLtoDR, startTimeout = 500, time = 5000 }, 
{timeout = 41274.418604651, num = 6, startPosition = {575, -120}, enemyType = 5, moving = movings.roundD, startTimeout = 500, time = 8000 }, 
{timeout = 44316.279069767, num = 3, startPosition = {-160, 80}, enemyType = 5, moving = movings.invertX(movings.zigzagTLtoDR), startTimeout = 500, time = 10000 }, 
{timeout = 47330.23255814, num = 6, startPosition = {545, -125}, enemyType = 6, moving = movings.turnTLtoDR, startTimeout = 500, time = 5000 }, 
{timeout = 50260.465116279, num = 5, startPosition = {570, -150}, enemyType = 4, moving = movings.eightTRtoDL, startTimeout = 400, time = 8000 }, 
{timeout = 53581.395348837, num = 3, startPosition = {-160, 80}, enemyType = 2, moving = movings.invertX(movings.zigzagTLtoDR), startTimeout = 500, time = 10000 }, 
{timeout = 56427.906976744, num = 4, startPosition = {575, -120}, enemyType = 3, moving = movings.roundD, startTimeout = 500, time = 8000 }, 
{timeout = 58688.372093023, num = 4, startPosition = {545, -125}, enemyType = 3, moving = movings.turnTLtoDR, startTimeout = 500, time = 5000 }, 
{timeout = 61981.395348837, num = 4, startPosition = {-195, 40}, enemyType = 5, moving = movings.invertX(movings.zigzagTRtoTL), startTimeout = 500, time = 12000 }, 
{timeout = 63879.069767442, num = 3, startPosition = {-160, 80}, enemyType = 1, moving = movings.invertX(movings.zigzagTLtoDR), startTimeout = 500, time = 10000 }, 
{timeout = 66725.581395349, num = 6, startPosition = {570, -150}, enemyType = 1, moving = movings.eightTRtoDL, startTimeout = 400, time = 8000 }, 
{timeout = 70465.11627907, num = 5, startPosition = {545, -125}, enemyType = 1, moving = movings.turnTLtoDR, startTimeout = 500, time = 5000 }, 
{timeout = 73060.465116279, num = 4, startPosition = {575, -120}, enemyType = 2, moving = movings.roundD, startTimeout = 500, time = 8000 }, 
{timeout = 75097.674418605, num = 3, startPosition = {-160, 80}, enemyType = 2, moving = movings.invertX(movings.zigzagTLtoDR), startTimeout = 500, time = 10000 }, 
{timeout = 77441.860465116, num = 4, startPosition = {575, -120}, enemyType = 4, moving = movings.roundD, startTimeout = 500, time = 8000 }, 
{timeout = 81376.744186047, num = 3, startPosition = {570, -150}, enemyType = 2, moving = movings.eightTRtoDL, startTimeout = 400, time = 8000 }, 
{timeout = 83162.790697674, num = 3, startPosition = {-160, 80}, enemyType = 1, moving = movings.invertX(movings.zigzagTLtoDR), startTimeout = 500, time = 10000 }, 
{timeout = 86065.11627907, num = 5, startPosition = {575, -120}, enemyType = 1, moving = movings.roundD, startTimeout = 500, time = 8000 }, 
{timeout = 89832.558139535, num = 4, startPosition = {-160, 80}, enemyType = 5, moving = movings.invertX(movings.zigzagTLtoDR), startTimeout = 500, time = 10000 }, 
{timeout = 92344.186046512, num = 3, startPosition = {70, -150}, enemyType = 4, moving = movings.invertX(movings.eightTRtoDL), startTimeout = 400, time = 8000 }, 
{timeout = 94744.186046512, num = 5, startPosition = {-160, 80}, enemyType = 2, moving = movings.invertX(movings.zigzagTLtoDR), startTimeout = 500, time = 10000 }, 
{timeout = 98037.209302326, num = 5, startPosition = {545, -125}, enemyType = 1, moving = movings.turnTLtoDR, startTimeout = 500, time = 5000 }, 
{timeout = 99851.162790698, num = 6, startPosition = {-195, 40}, enemyType = 5, moving = movings.invertX(movings.zigzagTRtoTL), startTimeout = 500, time = 12000 }, 
{timeout = 103116.27906977, num = 4, startPosition = {570, -150}, enemyType = 6, moving = movings.eightTRtoDL, startTimeout = 400, time = 8000 }, 
{timeout = 105627.90697674, num = 3, startPosition = {70, -150}, enemyType = 3, moving = movings.invertX(movings.eightTRtoDL), startTimeout = 400, time = 8000 }, 
{timeout = 108781.39534884, num = 5, startPosition = {-195, 40}, enemyType = 4, moving = movings.invertX(movings.zigzagTRtoTL), startTimeout = 500, time = 12000 }, 
{timeout = 111432.55813953, num = 6, startPosition = {70, -150}, enemyType = 6, moving = movings.invertX(movings.eightTRtoDL), startTimeout = 400, time = 8000 }, 
{timeout = 114893.02325581, num = 4, startPosition = {545, -125}, enemyType = 4, moving = movings.turnTLtoDR, startTimeout = 500, time = 5000 }, 
{timeout = 116874.41860465, num = 5, startPosition = {570, -150}, enemyType = 3, moving = movings.eightTRtoDL, startTimeout = 400, time = 8000 }, 

}





function lvl.init()
	
	
end

function lvl.start()
	
	
end

function lvl.destroy()
	EnemiesCreator.destroy()
end

function lvl.getEnemies()
	local allEnemies = EnemiesCreator.create(levelConfig)	
	return allEnemies
	
end

return lvl