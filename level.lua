require('history')
local storyboard = require( 'storyboard' )
local scene = storyboard.newScene( 'level' )
local HeroClass = require( 'HeroClass' )
local physics = require('physics')
local enemies = require('enemies')
require( "lib.tilebg" )
--local playhaven = require "plugin.playhaven"
local config = require( 'appconfig' )
local resources = require('resources')
local background = require( 'background' )

local groundGroup
local backObj
local btnExit
local hero

local levelSpriteSheet
local explosionSpriteSheet
local levelPreviewTimer

local snapshot


scene.selectedEpisodeId = 0
scene.selectedLevelId = 0


----------------------------------------------------------------------------------
-- 
--      NOTE:
--      
--      Code outside of listener functions (below) will only be executed once,
--      unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------


-- local forward references should go here --

function scene:resetAnchor(object)
        object.anchorX = 0
        object.anchorY = 0
end

function scene.btnExitTouched(event)
        if (event.phase == 'ended') then
                storyboard.gotoScene( "levelselect", {effect = 'fade', params = {episodeId = scene.selectedEpisodeId}} )
                storyboard.purgeScene( 'level' )
                return true
        end
        return true
end


function scene.loadAssets()
        local levelSheetObj = require('sprites.level')
        levelSpriteSheet = levelSheetObj.getSpriteSheet()

        local explosionSheetObj = require('sprites.explosion')
        explosionSpriteSheet = explosionSheetObj.getSpriteSheet()

        resources.loadLevel1Resources()

end

function scene.addRocketToScene(event)
        local group = scene.view
        group:insert(event.item)
end

function scene:addBackground()
        local group = self.view
        groundGroup = display.newGroup( )

        backObj = background.create(scene.selectedEpisodeId, groundGroup)

        group:insert(groundGroup)
end

function scene:addControls()
        local group = self.view
        btnExit = display.newImage( 'img/btn-exit.png' )
        self:resetAnchor(btnExit)
        btnExit.x = display.contentWidth - btnExit.contentWidth - 10
        btnExit.y = 10
        group:insert(btnExit)
end        

function scene:addHero()
        local group = self.view
        HeroClass.setLevelSprite(levelSpriteSheet)
        print('setExplosionSprite')
        HeroClass.setExplosionSprite(explosionSpriteSheet)
        hero = HeroClass.createHero()
        hero.x = display.contentWidth / 2
        hero.y = display.contentHeight - 100
        group:insert(hero)
        local rocketCreatedListener = scene.addRocketToScene
        hero:addEventListener( "rocketCreated", rocketCreatedListener )
end

function scene:addGameLogic()
        local group = self.view
        enemies.init(levelSpriteSheet)
        local enemyesGroup = enemies.createEnemies(self.selectedEpisodeId, self.selectedLevelId)
        group:insert(enemyesGroup)
        HeroClass.isFiring = true
        function allEnemiesDestroyed(event)
                HeroClass.isFiring = false
                enemies.destroy()
                --self:addLevelPreview()

        end
        function enemyFireAdded(event)
                group:insert(event.item)
        end
        enemyesGroup:addEventListener( 'allEnemiesDestroyed', allEnemiesDestroyed )
        enemyesGroup:addEventListener( 'enemyFireAdded', enemyFireAdded )
        
end

function scene:addLevelPreview()
        local group = self.view
        local myText = display.newText("Level ", display.contentWidth / 2, display.contentHeight / 2, native.systemFont, 36)
        transition.from( myText, {alpha = 0, delay = 1000} )
        group:insert(myText)
        function removePreview()
                if (myText and myText.isVisible) then
                        myText:removeSelf( )
                end
                self:addGameLogic()
        end
        levelPreviewTimer = timer.performWithDelay( 3000, removePreview, 1 )
end
        



---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
        local group = self.view

        self.selectedEpisodeId = event.params.episodeId
        self.selectedLevelId = event.params.levelId


        --if (config.ads) then
        --        playhaven.contentRequest("beforelevel", true)
        --end

        physics.start( )
        physics.setDrawMode( config.physicsMode )
        physics.setGravity(0, 0)

        self:loadAssets()

        self:addBackground()
        self:addControls()
        self:addHero()
        --self:addLevelPreview()
        self:addGameLogic()

        

        -----------------------------------------------------------------------------

        --      CREATE display objects and add them to 'group' here.
        --      Example use-case: Restore 'group' from previously saved state.

        -----------------------------------------------------------------------------

end


-- Called BEFORE scene has moved onscreen:
function scene:willEnterScene( event )
        local group = self.view

        local btnExitTouched = scene.btnExitTouched
        btnExit:addEventListener( "touch", btnExitTouched )

        

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
        history:setCurrent(history.SCREEN_LEVEL)
        history:setLevelId(self.selectedLevelId)

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local group = self.view

        local btnExitTouched = scene.btnExitTouched
        btnExit:removeEventListener( "touch", btnExitTouched )

        HeroClass.destroyHero()

        enemies.destroy()

        physics.stop()

        if (levelPreviewTimer) then
                timer.cancel( levelPreviewTimer )
                levelPreviewTimer = nil
        end

        backObj.destroy()

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