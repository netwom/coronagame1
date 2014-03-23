local storyboard = require( 'storyboard' )
local playhaven = require "plugin.playhaven"
display.setStatusBar( display.HiddenStatusBar )
storyboard.gotoScene('mainmenu')
local config = require( 'appconfig' )

--display.setDrawMode( "wireframe", true )

if (config.debug) then
	local myText = display.newText(display.fps, 30, 30, native.systemFont, 16)
	 
	local function updateText()
	    myText.txt = display.fps
	end
	 
	Runtime:addEventListener("enterFrame", updateText)
end

math.randomseed( os.time() )




local playhavenListener = function(event)
end

local init_options = {
    token = "82843c404ca547c5a08b60d0154a3d6a",
    secret = "2ea8aaa8d38a4671aee6f2599ff88329",
    --closeButton = system.pathForFile("closeButton.png", system.ResourceDirectory),
    --closeButtonTouched = system.pathForFile("closeButtonTouched.png", system.ResourceDirectory)
}
playhaven.init(playhavenListener, init_options)

