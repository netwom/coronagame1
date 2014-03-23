local sheet = {}

function sheet.getOptions()
	local options = {
		frames = {
			{
				x = 0, y = 0, width = 127, height = 98
			},
			{
				x = 0, y = 98, width = 13, height = 35
			}
		},
		sheetContentWidth = 128,
    	sheetContentHeight = 256
	}
	return options
end

function sheet.getSpriteSheet()
	local options = sheet.getOptions()
	local spriteSheet = graphics.newImageSheet( 'img/level.png', options)
	return spriteSheet
end


return sheet