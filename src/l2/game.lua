Game = Object:extend()

function Game:new()
    self.state = nil
    self.newState = nil
    self.dt = 0
    self.elapsed = 0
    self.paused = false
    self.speed = 1
end

function Game:init(state)
    self:switchState(state)
end

function Game:save()

end

function Game:switchState(state)
    self.newState = state
end

function Game:update(dt)
    if self.paused then
        dt = 0
    else
        dt = dt * self.speed
    end

    if self.newState ~= nil then
        if self.state then
            self.state:destroy()
        end

        self.state = self.newState
        self.state:init()
        self.newState = nil
    end

    self.dt = dt
    self.elapsed = self.elapsed + dt

    self.state:update(dt)
end

function Game:draw()
    self.state:draw()
end

game = Game()