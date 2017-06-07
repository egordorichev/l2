game = object:extend()

function game:new()
	self.speed = 1
	self.paused = false
	self.scale = 1
	self.width = love.graphics.getWidth() / self.scale
	self.height = love.graphics.getHeight() / self.scale
end

function game:init(s)
	font = love.graphics.newImageFont("data/fonts/font.png", 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890!?[](){}.,;:<>+=%#^*~/\\|$@&`"\'-_ 0', 1)

	love.graphics.setFont(font)
	love.graphics.setColor(255, 255, 255)

	self.elapsed = 0
	self.pendingState = nil
	self.currentState = nil

	self:switchState(s)
end

function game:switchState(s)
	self.pendingState = s
	self.pendingState:init()
end

function game:draw()
	camera.set()
	self.currentState:draw()
	camera.unset()
end

function game:update(dt)
	if self.paused then
		dt = 0
	else
		dt = dt * self.speed
	end

	if self.pendingState ~= nil then
		if self.currentState ~= nil then
			self.currentState:destroy()
		end

		self.currentState = self.pendingState
	end

	self.elapsed = self.elapsed + dt
	self.currentState:update(dt)

	input.reset()
end

function game:save()
	self.currentState:destroy()
end

game = game()