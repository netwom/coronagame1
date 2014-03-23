local sheet = {}

function sheet.getOptions()
	local options = {
		width = 128,
	    height = 128,
	    numFrames = 40,
	    sheetContentWidth = 1024,  --width of original 1x size of entire sheet
	    sheetContentHeight = 1024  --height of original 1x size of entire sheet
	}
	return options
end

function sheet.getSpriteSheet()
	local options = sheet.getOptions()
	local spriteSheet = graphics.newImageSheet( 'img/explosion.png', options)
	return spriteSheet
end


return sheet