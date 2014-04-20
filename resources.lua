local texturepacker = require('lib.texturepacker')
local resources = {}

resources.backElementsLevel1 = nil
resources.backElementsLevel1Data = nil

resources.pig = nil
resources.pigData = nil

resources.chicken1 = nil
resources.chicken1Data = nil

resources.egg = nil
resources.eggData = nil


function resources.loadLevel1Resources()
	if (resources.backElementsLevel1 == nil) then
		local sheetData = require ('sprites.back_elements_level1')
		resources.backElementsLevel1Data = sheetData.getSpriteSheetData()
		resources.backElementsLevel1Data = texturepacker.convertToNewData(resources.backElementsLevel1Data)
		resources.backElementsLevel1 = graphics.newImageSheet("img/sprites/back_elements_level1.png", resources.backElementsLevel1Data)
	end
	return resources.backElementsLevel1, resources.backElementsLevel1Data
end

function resources.loadChicken1Resources()
	if (resources.chicken1 == nil) then
		local sheetData = require ('sprites.chicken')
		resources.chicken1Data = sheetData.getSpriteSheetData()
		resources.chicken1Data = texturepacker.convertToNewData(resources.chicken1Data)
		resources.chicken1 = graphics.newImageSheet("img/sprites/chicken.png", resources.chicken1Data)
	end
	return resources.chicken1, resources.chicken1Data
end

function resources.loadPigResources()
	if (resources.pig == nil) then
		local sheetData = require ('sprites.pig')
		resources.pigData = sheetData.getSpriteSheetData()
		resources.pigData = texturepacker.convertToNewData(resources.pigData)
		resources.pig = graphics.newImageSheet("img/sprites/pig.png", resources.pigData)
	end
	return resources.pig, resources.pigData
end

function resources.loadEggResources()
	if (resources.egg == nil) then
		local sheetData = require ('sprites.egg')
		resources.eggData = sheetData.getSpriteSheetData()
		resources.eggData = texturepacker.convertToNewData(resources.eggData)
		resources.egg = graphics.newImageSheet("img/sprites/egg.png", resources.eggData)
	end
	return resources.egg, resources.eggData
end

return resources