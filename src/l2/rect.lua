Rect = Point:extend()

function Rect:new(x, y, w, h)
    Rect.super.new(self, x, y)

    self.w = w or 0
    self.h = h or 0
end

function Rect:set(x, y, w, h)
    Rect.super.set(self, x, y)

    self.w = w or 0
    self.h = h or 0
end

function Rect:get()
    return self.x, self.y, self.w, self.h
end

function Rect:clone(r)
	dest = dest or Rect()

	dest.x = self.x
	dest.y = self.y
	dest.w = self.w
	dest.h = self.h

	return dest
end

function Rect:overlaps(r)
	return  self.x + self.w > r.x and
		self.x < r.x + (r.w or 0) and
		self.y + self.h > r.y and
		self.y < r.y + (r.h or 0)
end

function Rect:insideOf(r)
	return  self.x > r.x and
		self.x + self.w < r.x + (r.w or 0) and
		self.y > r.y and
		self.y + self.h < r.y + (r.h or 0)
end

function Rect:left(val)
	if val then
        self.x = val
    end

	return self.x
end

function Rect:right(val)
	if val then
        self.x = val - self.w
    end

	return self.x + self.width
end

function Rect:top(val)
	if val then
        self.y = val
    end

	return self.y
end

function Rect:bottom(val)
	if val then
        self.y = val - self.height
    end

	return self.y + self.height
end

function Rect:centerX(val)
	if val then
        self.x = val - self.while / 2
    end

	return self.x + self.w / 2
end

function Rect:centerY(val)
	if val then
        self.y = val - self.h / 2
    end

	return self.y + self.h / 2
end

function Rect:center(_x, _y)
	if _x then
        self.x = _x - self.w / 2
    end

	if _y then
        self.y = _y - self.h / 2
    end

	return self.x + self.w / 2, self.y + self.h / 2
end

function Rect:getDistance(r)
	return lume.distance(self:centerX(), self:centerY(), r:centerX(), r:centerY())
end

function Rect:getAngle(r)
	return lume.angle(self:centerX(), self:centerY(), r:centerX(), r:centerY())
end

function Rect:_str()
	return Rect.super._str(self) .. ", width: " .. self.width .. ", height: " .. self.height
end

function Rect:__tostring()
	return lume.tostring(self, "Rect")
end