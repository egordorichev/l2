State = Object:extend()

function State:new()
	self.scene = nil
end

function State:init()
	self.scene = Scene(8)
end

function State:destroy()
	self.scene:destroy()
end

function State:update(dt)
	self.scene:update(dt)
end

function State:draw()
	self.scene:draw()
end