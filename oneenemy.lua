local COneEnemy = {}

function COneEnemy.create(startX, startY, radius)
	local enemy
	enemy = display.newCircle( startX, startY, radius )

	function enemy:destroy()
		self.isActive = false;
		self:removeSelf()
	end

	return enemy
end

return COneEnemy