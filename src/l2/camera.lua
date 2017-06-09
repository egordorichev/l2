Camera = Object:extend()

function Camera:new()
    self.x = 0
    self.y = 0
end

function Camera:set()
    love.graphics.push()
    love.graphics.translate(-self.x, -self.y)
end

function Camera:unset()
    love.graphics.pop()
end