local storyboard = require('storyboard')

history = {}

history.SCREEN_MENU 		= 1
history.SCREEN_EPISODES 	= 2
history.SCREEN_LEVELS		= 3
history.SCREEN_LEVEL 		= 4


history.current = 0
history.episode = 0
history.level = 0

function history:setCurrent(screenId)
	self.current = screenId
	print(self.current)
end

function history:setEpisodeId(episodeId)
	self.episode = episodeId
end

function history:setLevelId(levelId)
	self.level = levelId
end

function history:back()
	if (self.current == history.SCREEN_LEVEL) then
		storyboard.gotoScene( 'levelselect', {effect = 'fade', params = {episodeId = self.episode}} )
		return true
	elseif (self.current == history.SCREEN_LEVELS) then
		storyboard.gotoScene( 'episodeselect', {effect = 'fade'} )
		return true
	elseif (self.current == history.SCREEN_EPISODES) then
		storyboard.gotoScene( 'mainmenu', {effect = 'fade'} )
		return true
	elseif (self.current == history.SCREEN_MENU) then
		return false
	end
end

local function onKeyEvent(event)
	local phase = event.phase
   	local keyName = event.keyName
   	if ( "back" == keyName and phase == "up" ) then
   		return history:back()
   	end

   	if ( "left" == keyName and phase == "up" ) then
   		return history:back()
   	end

end

Runtime:addEventListener( "key", onKeyEvent )