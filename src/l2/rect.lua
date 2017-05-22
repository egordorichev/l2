rect = object:extend()

function rect:new(x, y, w, h)
	self:set(x, y, w, h)
end

function rect:getPosition()
	return self.x, self.y
end

function rect:getSize()
	return self.w, self.h
end

function rect:left(val)
	if val then self.x = val end
	return self.x
end

function rect:right(val)
	if val then self.x = val - self.w end
	return self.x + self.w
end

function rect:top(val)
	if val then self.y = val end
	return self.y
end

function rect:bottom(val)
	if val then self.y = val - self.h end
	return self.y + self.h
end

function rect:getMiddleX()
	return self.x + self.w / 2
end

function rect:getMiddleY()
	return self.y + self.h / 2
end

function rect:setPosition(x, y)
	self.x = x or 0
	self.y = y or 0
end

function rect:setSize(w, h)
	self.w = w or 0
	self.h = h or 0
end

function rect:set(x, y, w, h)
	self:setPosition(x, y)
	self:setSize(w, h)
end

function rect:move(v)
	self.x = self.x + v.x
	self.y = self.y + v.y
end

function rect:contains(r)
	return r.x >= self.x and r.x + r.w <= self.x + self.w and
		r.y >= self.y and r.y + r.h <= self.y + self.h
end

function rect:overlapsX(r)
	return self.x < r.x + r.w and self.x + self.w > r.x
end

function rect:overlapsY(r)
	return self.y < r.y + r.h and self.y + self.h > r.y
end

function rect:overlaps(r)
	return r.x + r.w > self.x and r.x < self.x + self.w and
		r.y + r.h > self.y and r.y < self.y + self.h
end

function rect:containsPoint(x, y)
	return x > self.x and x < self.x + self.w
		and y > self.y and y < self.y + self.h
end

function rect:copy(r)
	local r = r or rect()
	r:set(self.x, self.y, self.w, self.h)

	return r
end

function rect:__tostring()
	return lume.format("({x}, {y}, {w}, {h})", self)
end