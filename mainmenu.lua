local storyboard = require( 'storyboard' )
local scene = storyboard.newScene( 'mainmenu' )
local playhaven = require "plugin.playhaven"
local ads = require "ads"
local config = require( 'appconfig' )
local carrot = require "plugin.carrot"
local facebook = require "facebook"

local btnStart
local btnMoreGames
local btnPostFb

----------------------------------------------------------------------------------
-- 
--      NOTE:
--      
--      Code outside of listener functions (below) will only be executed once,
--      unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------


-- local forward references should go here --

local function adListener( event )
    if event.isError then
        -- Failed to receive an ad.
    end
end

function scene.btnStartTouched(event)
	if(event.phase == 'ended') then
		storyboard.gotoScene('level')
                playhaven.setNotificationBadge({clear = true})
	end
end

function scene.btnMoreGamesTouched(event)
        if(event.phase == 'ended') then
                playhaven.contentRequest("moregames", true)
        end
end

function scene.btnPostFbTouched(event)
        if(event.phase == 'ended') then
                carrot.init("228891373981668", "bee51302cc1e74e807569fbcb28c24e1")
                facebook.login("228891373981668", function(event)

    -- If the login was successful, pass the user token to Carrot
            if event.type == "session" and event.phase == "login" then

                -- Pass user token to Carrot for validation.
                carrot.validateUser(event.token)
                --carrot.postAction("finish", "finishround")
            end

            -- The 'publish_actions' permission is required for Carrot functionality ('publish_stream' is a superset of 'publish_actions', but is deprecated).
        end, {"publish_actions"})
        end
end


---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
        local group = self.view
        btnStart = display.newImage( 'img/btn-start.png' )
        btnStart.x = display.contentWidth / 2
        btnStart.y = display.contentHeight / 2
        group:insert(btnStart)

        btnMoreGames = display.newImage( 'img/more_games.png' )
        btnMoreGames.x = display.contentWidth / 2
        btnMoreGames.y = display.contentHeight / 2 + 100
        group:insert(btnMoreGames)

        btnPostFb =  display.newImage( 'img/fb-post.png' )
        btnPostFb.x = display.contentWidth / 2
        btnPostFb.y = display.contentHeight / 2 + 200
        group:insert(btnPostFb)



        playhaven.setNotificationBadge({x=btnMoreGames.x + 130, y=btnMoreGames.y - 40, clear=false, test=true, placement="moregames", orientation=system.orientation})

        if (config.ads) then
                ads.init( "admob", "ca-app-pub-0945737213584036/8213261791", adListener )
                ads.show( "banner", { x=0, y=0 } )
        end

        -----------------------------------------------------------------------------

        --      CREATE display objects and add them to 'group' here.
        --      Example use-case: Restore 'group' from previously saved state.

        -----------------------------------------------------------------------------

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

        local btnStartTouched = scene.btnStartTouched
        btnStart:addEventListener( "touch", btnStartTouched )

        local btnMoreGamesTouched = scene.btnMoreGamesTouched
        btnMoreGames:addEventListener( "touch", btnMoreGamesTouched )

        local btnPostFbTouched = scene.btnPostFbTouched
        btnPostFb:addEventListener( "touch", btnPostFbTouched )

        -----------------------------------------------------------------------------

        --      INSERT code here (e.g. start timers, load audio, start listeners, etc.)

        -----------------------------------------------------------------------------

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local group = self.view
        local btnStartTouched = scene.btnStartTouched
        btnStart:removeEventListener( "touch", btnStartTouched )

        local btnMoreGamesTouched = scene.btnMoreGamesTouched
        btnMoreGames:removeEventListener( "touch", btnMoreGamesTouched )

        local btnPostFbTouched = scene.btnPostFbTouched
        btnPostFb:removeEventListener( "touch", btnPostFbTouched )
        --btnStart:removeSelf()
        --btnStart = nil

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