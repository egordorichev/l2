game = object:extend()
local canvas

function game:new()
	self.speed = 1
	self.paused = false
	self.scale = 3
	self.width = love.graphics.getWidth() / self.scale
	self.height = love.graphics.getHeight() / self.scale

	canvas = love.graphics.newCanvas(love.graphics.getWidth(), love.graphics.getHeight())
	canvas:setFilter("nearest", "nearest")
end

function game:init(state)
	self.elapsed = 0
	self.pendingState = nil

	self:switchState(state())
end

function game:switchState(state)
	self.pendingState = state
end

function game:draw()
	love.graphics.setCanvas(canvas)
	love.graphics.clear()

	camera.set()
	self.state:draw()
	camera.unset()

	love.graphics.setCanvas()
	love.graphics.draw(canvas, 0, 0, 0, self.scale, self.scale)
end

function game:update(dt)
	if self.paused then
		dt = 0
	else
		dt = dt * self.speed
	end

	if self.pendingState ~= nil then
		if self.state ~= nil then
			self.state:destroy()
		end

		self.state = self.pendingState
		self.state:init()
	end

	self.elapsed = self.elapsed + dt
	self.state:update(dt)
end

function game:save()
	self.state:destroy()
end

game = game()