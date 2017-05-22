assets = {
	map = {}
}

function assets.load(fileName)
	local resource = assets.get(fileName)

	if not resource then
		if fileName:match("%.png$") then
			resource = love.graphics.newImage(fileName)
		elseif fileName:match("%.ogg$") or fileName:match("%.wav") then
			resource = love.audio.newSource(fileName)
		else
			resource = love.filesystem.read(fileName)
		end

		assets.map[fileName] = resource
	end

	return resource
end

function assets.get(fileName)
	return assets.map[fileName]
end

function assets.clear()
	assets.map = {}
end