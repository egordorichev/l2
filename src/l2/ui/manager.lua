uiManager = object:extend()

function uiManager:new()
	self.components = {}
end

function uiManager:add(c)
	table.insert(self.components, c)
end

function uiManager:remove(c)
	lume.remove(self.components, c)
end

function uiManager:draw()
	for k, c in pairs(self.components) do
		c:updateAndDraw()
	end
end