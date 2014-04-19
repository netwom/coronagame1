local texturepacker = require('lib.texturepacker')
local resources = {}

resources.backElementsLevel1 = nil
resources.backElementsLevel1Data = nil

function resources.loadLevel1Resources()
	if (resources.backElementsLevel1 == nil) then
		local sheetData = require ('sprites.back_elements_level1')
		resources.backElementsLevel1Data = sheetData.getSpriteSheetData()
		resources.backElementsLevel1Data = texturepacker.convertToNewData(resources.backElementsLevel1Data)
		--resources.backElementsLevel1 = sprite.newSpriteSheetFromData( "img/sprites/back_elements_level1.png", data )
		resources.backElementsLevel1 = graphics.newImageSheet("img/sprites/back_elements_level1.png", resources.backElementsLevel1Data)
		--resources.backElementsLevel1 = display.newSprite( imageSheet, data )
	end
	return resources.backElementsLevel1, resources.backElementsLevel1Data
end

return resources