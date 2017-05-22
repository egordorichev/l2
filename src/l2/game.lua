game = object:extend()

function game:new()
	self.speed = 1
	self.paused = false
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
	love.graphics.clear()
	self.state:draw()
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