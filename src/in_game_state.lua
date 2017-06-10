InGameState = State:extend()

function InGameState:init()
	InGameState.super.init(self)

	self.name = "ingame"
	self.scene:add(player)
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