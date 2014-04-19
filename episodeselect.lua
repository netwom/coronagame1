require('history')
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

----------------------------------------------------------------------------------
-- 
--      NOTE:
--      
--      Code outside of listener functions (below) will only be executed once,
--      unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------


-- local forward references should go here --

local EPISODES_COUNT = 3

local episodes = {}
local navs = {}
local episodesGroup, navGroup

local episodesStartX
local isAnimated = false
local canEnterEpisode = true


---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

function scene.setCurrentNav(idx)
        for i=1,#navs do
                navs[i]:setFillColor( 0.2 )
        end
        navs[idx]:setFillColor( 1 )
end

function scene.touchEpisode(event)
        if (event.phase == 'ended') then
                if (canEnterEpisode) then
                        print('enter episode')
                        print(event.target.id)
                        storyboard.gotoScene( 'levelselect', {effect = 'fade', params = {episodeId = event.target.id}} )
                end
        end

end

function scene.onTouch(event)
        if (isAnimated == false) then
                if (event.phase == 'began') then
                        canEnterEpisode = true
                        episodesStartX = episodesGroup.x
                elseif (event.phase == 'moved') then
                        local delta = event.xStart - event.x                        
                        if (math.abs(delta) > 20) then
                                episodesGroup.x = episodesStartX - delta
                                canEnterEpisode = false
                        end
                elseif (event.phase == 'ended') then
                        isAnimated = true
                        local nextX = 0
                        local moveTime = 300
                        local minMoveDistance = 200
                        if (math.abs(episodesStartX - episodesGroup.x) > minMoveDistance) then
                                if (episodesStartX > episodesGroup.x) then
                                        nextX = episodesStartX - display.contentWidth
                                else
                                        nextX = episodesStartX + display.contentWidth
                                end
                        else
                                nextX = episodesStartX
                        end
                        if (nextX > 0 ) then
                                nextX = 0
                        elseif(nextX < -(display.contentWidth * (EPISODES_COUNT - 1))) then
                                nextX = -(display.contentWidth * (EPISODES_COUNT - 1))
                        end
                        --moveTime = moveTime * (display.contentWidth - math.abs(episodesGroup.x - episodesStartX)) / display.contentWidth
                        transition.to( episodesGroup, {x = nextX, time = moveTime, transition=easing.outBack, onComplete = function()
                                local navIdx = math.abs(nextX) / display.contentWidth + 1
                                scene.setCurrentNav(navIdx)
                                isAnimated = false 
                                canEnterEpisode = true
                                end} )
                end
        end
end

function scene:createButtons()
        local group = self.view

        episodesGroup = display.newGroup();

        for i=1,EPISODES_COUNT do
                local episode = display.newRect( display.contentWidth * (i - 1) +  display.contentWidth / 2,  display.contentHeight / 2, 440, 736 )
                episode.id = i
                episodesGroup:insert(episode)
                episodes[#episodes + 1] = episode
                local touchEpisode = scene.touchEpisode
                episode:addEventListener( 'touch', touchEpisode )
        end

        group:insert(episodesGroup)
end

function scene:createNavigation()
        local group = self.view
        local radius = 10;
        local between = 40

        navGroup = display.newGroup( )

        for i=1,EPISODES_COUNT do
                local nav = display.newCircle( (i - 1) * between, 0, radius )
                nav:setFillColor( 0.2 )
                navGroup:insert(nav)
                navs[#navs + 1] = nav
        end

        navs[1]:setFillColor( 1 )


        navGroup.x = display.contentWidth / 2 - ((EPISODES_COUNT - 1) * 40 / 2)
        navGroup.y = display.contentHeight - 100

        group:insert(navGroup)


end


-- Called when the scene's view does not exist:
function scene:createScene( event )
        local group = self.view

        -----------------------------------------------------------------------------

        --      CREATE display objects and add them to 'group' here.
        --      Example use-case: Restore 'group' from previously saved state.

        -----------------------------------------------------------------------------
        self:createButtons()
        self:createNavigation()
        


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

        local onTouch = scene.onTouch
        Runtime:addEventListener('touch', onTouch)

        history:setCurrent(history.SCREEN_EPISODES)

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local group = self.view

        -----------------------------------------------------------------------------

        --      INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)

        -----------------------------------------------------------------------------

        local onTouch = scene.onTouch
        Runtime:removeEventListener('touch', onTouch)

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