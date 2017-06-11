Camera = Entity:extend()

function Camera:new(follow)
    Camera.super.new(self)
    self.follow = follow
    self.speed = 2
	self.w = WIDTH
	self.h = HEIGHT
end

function Camera:set()
    love.graphics.push()
    love.graphics.translate(-self.x, -self.y)
end

function Camera:unset()
    love.graphics.pop()
end

function Camera:update(dt)
    if self.follow ~= nil then
        if self:getDistance(self.follow) > 5 then
            self.x = lume.lerp(self.x, self.follow:getCenterX() - self.w / 2, self.speed)
            self.y = lume.lerp(self.y, self.follow:getCenterY() - self.h / 2, self.speed)
        end
    end
end