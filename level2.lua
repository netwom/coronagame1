local collisions = require( 'collisions' )

local lvl = display.newGroup( )
local enemies = {}
local timerId
local numEnemies = 5
local curve
local curveRoundTime = 2000

local framesX = {0,50.4706,100.956,151.471,201.95,252.442,302.969,353.401,403.921,454.439,504.935,555.406,605.954,656.417,706.917,757.417,807.912,858.401,908.923,932.163,929.396,926.63,923.861,921.093,918.327,915.562,912.791,910.025,907.257,904.49,901.722,898.954,896.188,854.066,803.547,753.053,702.536,652.029,601.462,550.942,500.453,449.899,399.393,348.883,298.368,247.868,197.479,147.777,120.507,164.483,214.225,264.55,315.002,365.553,416.074,466.541,516.735,565.959,612.659,650.909,626.773,576.385,525.839,475.389,424.89,374.374,323.845,273.474,223.441,174.396,128.921,115.646,163.286,213.635,264.192,314.649,365.194,415.673,466.179,516.341,565.719,613.54,656.969,665.799,617.517,567.173,516.64,466.153,415.626,365.086,314.62,264.129,213.647,163.432,114.305,119.281,167.808,217.774,268.091,318.444,368.955,419.374,469.722,520.019,570.088,619.668,666.847,649.863,600.685,550.634,500.343,450.013,399.573,349.133,298.599,248.089,197.591,147.032,96.5261,46}
local framesY = {0,1.5136,3.02765,4.54258,6.05643,7.57069,9.08599,10.5984,12.1135,13.6285,15.1429,16.6565,18.1725,19.6858,21.2003,22.7148,24.2291,25.7433,27.2585,55.098,105.536,155.952,206.441,256.879,307.3,357.712,408.208,458.64,509.097,559.535,609.985,660.434,710.858,719.576,719.367,719.16,718.956,718.755,718.557,718.363,718.175,717.997,717.836,717.78,718.043,717.226,714.016,705.24,671.983,649.351,640.821,636.475,634.302,633.507,633.681,632.735,627.254,616.033,596.979,564.743,535.31,532.206,532.517,533.855,535.326,536.253,535.732,532.462,525.563,513.529,491.96,449.98,435.143,431.752,431.308,432.025,433.09,433.91,431.999,426.013,415.534,399.388,373.933,331.904,318.466,314.683,313.888,314.535,315.727,315.51,314.541,313.022,310.282,305.259,293.9,259.754,246.151,238.921,234.18,230.779,228.133,225.359,221.558,216.535,209.839,200.297,182.795,150.311,138.974,132.169,127.286,123.45,120.067,118.027,117.371,117.313,117.619,118.188,118.966,119.95}
local frameId = 0
local checkEnemiesTimer

local startX = -50
local startY = -50

function lvl.onEnterFrame(event)
	frameId = frameId + 1
	if (frameId % 3 == 0) then
		for i=1, #enemies do
			local oneEnemy = enemies[i]
			oneEnemy.currentFrame = oneEnemy.currentFrame + 1
			if (oneEnemy.currentFrame > 0 and oneEnemy.currentFrame <= #framesX) then
				transition.to( oneEnemy, {x = framesX[oneEnemy.currentFrame], y = framesY[oneEnemy.currentFrame], delay = 100} )
				--oneEnemy.x = framesX[oneEnemy.currentFrame]
				--oneEnemy.y = framesY[oneEnemy.currentFrame]
			end
			if (oneEnemy.currentFrame > #framesX) then
				oneEnemy.currentFrame = -10
			end

		end
	end
end

function lvl.init()
	print('level init')
	for i=1, #framesX do
		framesX[i] = framesX[i] + startX
		framesY[i] = framesY[i] + startY
	end
	
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

	for i=1, numEnemies do
		local oneEnemy = COneEnemy.create(startX, startY, 50)
		
		oneEnemy.health = 5
		oneEnemy.currentFrame = -10 * i
		physics.addBody( oneEnemy, 'static', { radius=50, filter=collisions.enemyFilter } )
		table.insert( enemies, oneEnemy )
	end

	return enemies
end

return lvl