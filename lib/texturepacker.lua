local texturepacker = {}

function texturepacker.convertToNewData(data)
	local newData = {frames = {}}
	for i=1,#data.frames do
		local idx = #newData.frames + 1
		newData.frames[idx] = data.frames[i].textureRect
		newData.frames[idx].name = data.frames[i].name
		newData.frames[idx].newId = idx
	end

	function newData:find(name)
		for i=1,#self.frames do
			if (self.frames[i].name == name) then
				return self.frames[i]
			end
		end
	end

	return newData
end

return texturepacker 