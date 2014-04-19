require('history')
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

scene.episodeId = 0

local LEVELS_NUM = 12
local NUM_IN_ROW = 3
local ITEM_WIDTH = 160
local ITEM_HEIGHT = 160
local ITEM_MARGIN = 20

local itemsGroup

----------------------------------------------------------------------------------
-- 
--      NOTE:
--      
--      Code outside of listener functions (below) will only be executed once,
--      unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------


-- local forward references should go here --


---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

function scene.levelItemTouched(event)
	if (event.phase == 'ended') then
		storyboard.gotoScene( 'level', {effect = 'fade', params = {episodeId = scene.episodeId, levelId = event.target.levelId}} )
	end
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
        local group = self.view
        scene.episodeId = event.params.episodeId

        itemsGroup = display.newGroup( )

        -----------------------------------------------------------------------------

        --      CREATE display objects and add them to 'group' here.
        --      Example use-case: Restore 'group' from previously saved state.

        -----------------------------------------------------------------------------

        local groupWidth = ITEM_WIDTH * NUM_IN_ROW + (NUM_IN_ROW - 1) * ITEM_MARGIN
        local groupHeight = math.ceil( LEVELS_NUM / NUM_IN_ROW ) * ITEM_HEIGHT + (math.ceil( LEVELS_NUM / NUM_IN_ROW ) - 1) * ITEM_MARGIN
        for i=1,LEVELS_NUM do
        	local item = display.newRect( 0, 0, ITEM_WIDTH, ITEM_HEIGHT )
        	item.levelId = i
        	item.anchorX = 0
        	item.anchorY = 0
        	itemsGroup:insert(item)
        	local rowId = math.floor( (i - 1) / NUM_IN_ROW ) 
        	local colId = (i - 1) % NUM_IN_ROW
        	item.x = colId * ITEM_WIDTH + colId * ITEM_MARGIN
        	item.y = rowId * ITEM_HEIGHT + rowId  * ITEM_MARGIN
        	local levelItemTouched = scene.levelItemTouched
        	item:addEventListener( 'touch', levelItemTouched )
        end

        itemsGroup.x = (display.contentWidth - groupWidth) / 2
        itemsGroup.y = (display.contentHeight - groupHeight) / 2

        group:insert(itemsGroup)

end


-- Called BEFORE scene has moved onscreen:
function scene:willEnterScene( event )
        local group = self.view

        -----------------------------------------------------------------------------

        --      This event requires build 2012.782 or later.

        -----------------------------------------------------------------------------

end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
        local group = self.view

        -----------------------------------------------------------------------------

        --      INSERT code here (e.g. start timers, load audio, start listeners, etc.)

        -----------------------------------------------------------------------------

        history:setCurrent(history.SCREEN_LEVELS)
        history:setEpisodeId(scene.episodeId)

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local group = self.view

        -----------------------------------------------------------------------------

        --      INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)

        -----------------------------------------------------------------------------

end


-- Called AFTER scene has finished moving offscreen:
function scene:didExitScene( event )
        local group = self.view

        -----------------------------------------------------------------------------

        --      This event requires build 2012.782 or later.

        -----------------------------------------------------------------------------

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
        local group = self.view

        -----------------------------------------------------------------------------

        --      INSERT code here (e.g. remove listeners, widgets, save state, etc.)

        -----------------------------------------------------------------------------

end


-- Called if/when overlay scene is displayed via storyboard.showOverlay()
function scene:overlayBegan( event )
        local group = self.view
        local overlay_name = event.sceneName  -- name of the overlay scene

        -----------------------------------------------------------------------------

        --      This event requires build 2012.797 or later.

        -----------------------------------------------------------------------------

end


-- Called if/when overlay scene is hidden/removed via storyboard.hideOverlay()
function scene:overlayEnded( event )
        local group = self.view
        local overlay_name = event.sceneName  -- name of the overlay scene

        -----------------------------------------------------------------------------

        --      This event requires build 2012.797 or later.

        -----------------------------------------------------------------------------

end



---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "willEnterScene" event is dispatched before scene transition begins
scene:addEventListener( "willEnterScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "didExitScene" event is dispatched after scene has finished transitioning out
scene:addEventListener( "didExitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-- "overlayBegan" event is dispatched when an overlay scene is shown
scene:addEventListener( "overlayBegan", scene )

-- "overlayEnded" event is dispatched when an overlay scene is hidden/removed
scene:addEventListener( "overlayEnded", scene )

---------------------------------------------------------------------------------

return scene
    