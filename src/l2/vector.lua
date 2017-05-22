vector = object:extend()

function vector:new(x, y)
    self:set(x, y)
end

function vector:add(v)
    self.x = self.x + v.x
    self.y = self.y + v.y
end

function vector:subtract(v)
    self.x = self.x - v.x
    self.y = self.y - v.y
end

function vector:multiply(value)
    self.x = self.x * value
    self.y = self.y * value
end

function vector:divide(value)
    self.x = self.x / value
    self.y = self.y / value
end

function vector:set(x, y)
	self.x = x or 0
	self.y = y or 0
end

function vector:copy(d)
	local d = d or vector()
	d:set(self.x, self.y)

    return d
end