local resources = require('resources')
local background = {}

background.items = {}
background.speed = 3

local backgroundsConfig = {}

function background.create(episodeId, group)

	local backObj = {}

	local episode1Sheet, data = resources.loadLevel1Resources()
	local backImg = display.newSprite( episode1Sheet, {name = 'back', start = data:find('back1.png').newId, count = 1} )
	backImg.x = display.contentWidth / 2
	backImg.y = display.contentHeight / 2
	backImg.xScale = 2
	backImg.yScale = 2
	group:insert(backImg)


	background.items = display.newGroup( )
	local images = {'beam.png', 'bush.png', 'callboard.png', 'fence.png', 'grass1.png', 'grave.png', 'plant.png', 'stone1.png', 'stone2.png', 
					'stump.png', 'tree1.png', 'tree2.png', 'tree3.png', 'trod.png', 'wc.png'}
	--for i=1,50 do
	--	local imgIdx = math.random(1, #images )
	--	local newItem = display.newSprite( episode1Sheet, {name = 'back', start = data:find(images[imgIdx]).newId, count = 1} )
	--	newItem.x = math.random(50, display.contentWidth - 50 )
	--	newItem.y = 1136 - 200 * i
	--	background.items:insert(newItem)
	--end
	--group:insert(background.items)

	function backObj:loadXml()
		local xml = require('lib.xml').newParser()
		local xmlFile = 'levels/episode' .. episodeId .. '/backgrounds.xml'
		local inbox = xml:loadFile( xmlFile )
		
		-- print(#inbox.child[1].child) -- media
		-- print(#inbox.child[2].child) -- symbols
		-- print(#inbox.child[3].child) -- timelines
		local timelines = inbox.child[3]
		for nDOMTimeline=1,#timelines.child do
			local DOMTimeline = timelines.child[nDOMTimeline]
			local layers = DOMTimeline.child[1]
			for nDOMLayer=1,#layers.child do
				local DOMLayer = layers.child[nDOMLayer]

				local newVariant = {}

				local frames = DOMLayer.child[1]
				local DOMFrame = frames.child[1]
				local elements = DOMFrame.child[1]
				for nDOMBitmapInstance=1,#elements.child do

					local DOMBitmapInstance = elements.child[nDOMBitmapInstance]
					local matrix = DOMBitmapInstance.child[1]
					local mmatrix = matrix.child[1]

					local itemName = DOMBitmapInstance.properties['libraryItemName'] or 'name'
					local tx = mmatrix.properties['tx'] or 0
					local ty = mmatrix.properties['ty'] or 0

					--print(itemName .. ' ::: ' ..  tx .. ' --- ' .. ty)

					local newElement = {name = itemName, x = tx, y = ty}
					print('insert element')
					newVariant[#newVariant + 1] = newElement

				end
				print('insert variant')
				backgroundsConfig[#backgroundsConfig + 1] = newVariant
			end
		end
	end

	function backObj:drawBackground(startY)
		local variantId=math.random(1,#backgroundsConfig)
		local variant = backgroundsConfig[variantId]
		for itemId=1,#variant do
			local item = variant[itemId]
			--item.name, item.x, item.y
			local y = startY + item.y

			local newItem = display.newSprite( episode1Sheet, {name = 'back', start = data:find(item.name).newId, count = 1} )
			newItem.anchorX = 0
			newItem.anchorY = 0
			newItem.x = item.x
			newItem.y = y
			background.items:insert(newItem)				
		end
		group:insert(background.items)
		
	end


	

	function backObj.enterFrame(event)
		if (background.items) then
			background.items.y = background.items.y + background.speed
		end
	end

	function backObj.destroy()
		Runtime:removeEventListener('enterFrame', backObj)
	end

	Runtime:addEventListener( 'enterFrame', backObj )
	backObj:loadXml()

	for i=1,50 do
		local dY = -1136 - (1136 * (i - 1) * 2 )
		backObj:drawBackground(dY)
	end
	

	return backObj
end

return background