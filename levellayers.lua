local levelLayers = {}

levelLayers.enemiesLayer = nil
levelLayers.heroLayer = nil
levelLayers.weaponLayer = nil
levelLayers.explosionLayer = nil
levelLayers.backgroundLayer = nil

function levelLayers.get()
	if (levelLayers.enemiesLayer == nil) then
		levelLayers.enemiesLayer = display.newGroup( )
		levelLayers.heroLayer = display.newGroup( )
		levelLayers.weaponLayer = display.newGroup( )
		levelLayers.explosionLayer = display.newGroup( )
		levelLayers.backgroundLayer = display.newGroup( )
	end
	return levelLayers.enemiesLayer, levelLayers.heroLayer, levelLayers.weaponLayer, levelLayers.explosionLayer, levelLayers.backgroundLayer
end



function levelLayers.clear()
	levelLayers.enemiesLayer = nil
	levelLayers.heroLayer = nil
	levelLayers.weaponLayer = nil
	levelLayers.explosionLayer = nil
	levelLayers.backgroundLayer = nil
end


return levelLayers