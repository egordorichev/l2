InGameState = State:extend()

function InGameState:init()
	InGameState.super.init(self)

	self.name = "ingame"
	self.scene:add(player)

	map:loadLua("data/maps/1.lua", lume.fn(self.loadObject, self))

	map:loadMetaImage("data/images/meta.png", {

	})

	self.scene:add(map)
end

function InGameState:loadObject(layer, obj)

end

function InGameState:destroy()
	InGameState.super.destroy(self)
end

function InGameState:update(dt)
	InGameState.super.update(self, dt)
end

function InGameState:draw()
	InGameState.super.draw(self)
end