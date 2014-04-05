local collisions = require( 'collisions' )
local movings = require('movings')
local EnemiesCreator = require('enemiescreator')

local lvl = display.newGroup( )

local levelConfig = {
	{timeout = 1000, num = 4, startPosition = {800, 80}, enemyType = 1, moving = movings.zigzagTLtoDR, startTimeout = 300, time = 5000 },

	{timeout = 3000, 
	 num = 6, 
	 startPosition = {-100, 80}, 
	 enemyType = 2, 
	 moving = movings.invertX(movings.zigzagTLtoDR), 
	 startTimeout = 300, 
	 time = 5000 },

	 {timeout = 7000, 
	 num = 6, 
	 startPosition = {80, -50}, 
	 enemyType = 3, 
	 moving = movings.zigzagTtoD, 
	 startTimeout = 300, 
	 time = 4000 },

	 {timeout = 9000, 
	 num = 6, 
	 startPosition = {560, -50}, 
	 enemyType = 4, 
	 moving = movings.invertX(movings.zigzagTtoD), 
	 startTimeout = 300, 
	 time = 4000 },

	 --roundD 575, -120
	 {timeout = 13000, 
	 num = 6, 
	 startPosition = {575, -120}, 
	 enemyType = 5, 
	 moving = movings.roundD, 
	 startTimeout = 300, 
	 time = 4000 },

	 {timeout = 15000, 
	 num = 6, 
	 startPosition = {65, -120}, 
	 enemyType = 6, 
	 moving = movings.invertX(movings.roundD), 
	 startTimeout = 300, 
	 time = 4000 },

	 --movings.zigzagTRtoTL
	 {timeout = 19000, 
	 num = 6, 
	 startPosition = {835, 40}, 
	 enemyType = 1, 
	 moving = movings.zigzagTRtoTL, 
	 startTimeout = 300, 
	 time = 6000 },

	 {timeout = 22000, 
	 num = 6, 
	 startPosition = {-195, 40}, 
	 enemyType = 1, 
	 moving = movings.invertX(movings.zigzagTRtoTL), 
	 startTimeout = 300, 
	 time = 6000 },

	 --movings.turnTLtoDR
	 {timeout = 28000, 
	 num = 6, 
	 startPosition = {545, -125}, 
	 enemyType = 1, 
	 moving = movings.turnTLtoDR, 
	 startTimeout = 300, 
	 time = 4000 },

	 {timeout = 31000, 
	 num = 6, 
	 startPosition = {95, -125}, 
	 enemyType = 1, 
	 moving = movings.invertX(movings.turnTLtoDR), 
	 startTimeout = 300, 
	 time = 4000 },

	 --movings.roundTRtoDR
	 {timeout = 35000, 
	 num = 6, 
	 startPosition = {550, -140}, 
	 enemyType = 1, 
	 moving = movings.roundTRtoDR, 
	 startTimeout = 300, 
	 time = 4000 },

	 {timeout = 38000, 
	 num = 6, 
	 startPosition = {90, -140}, 
	 enemyType = 1, 
	 moving = movings.invertX(movings.roundTRtoDR), 
	 startTimeout = 300, 
	 time = 4000 },

	 --movings.eightTRtoDL
	 {timeout = 42000, 
	 num = 6, 
	 startPosition = {570, -150}, 
	 enemyType = 1, 
	 moving = movings.eightTRtoDL, 
	 startTimeout = 300, 
	 time = 4000 },

	 {timeout = 45000, 
	 num = 6, 
	 startPosition = {70, -150}, 
	 enemyType = 1, 
	 moving = movings.invertX(movings.eightTRtoDL), 
	 startTimeout = 300, 
	 time = 4000 },

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