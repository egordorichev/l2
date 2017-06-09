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
    Rect.super.clone(self, r)

    if r:is(Rect) then
    	self.w = r.w
    	self.h = r.h
    end
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

function Rect:getDistance(r)
	local x1, y1 = self:centerX(), self:centerY()
	local x2 = r:is(Rect) and r:centerX() or r.x
	local y2 = r:is(Rect) and r:centerY() or r.y

	return lume.distance(self.x + self.w / 2, self.y + self.h / 2, r.x + (r.w and r.w / 2 or 0), r.y + (r.h and r.h / 2 or 0))
end

function Rect:getDistanceX(r)
	local x1, y1 = self:centerX()
	local x2 = r:is(Rect) and r:centerX() or r.x

	return math.abs((self.x + self.w / 2) - (r.x + (r.w and r.w / 2 or 0)))
end

function Rect:getDistanceY(r)
	local x1, y1 = self:centerY()
	local x2 = r:is(Rect) and r:centerY() or r.y

	return math.abs((self.y + self.w / 2) - (r.y + (r.w and r.w / 2 or 0)))
end

function Rect:getAngle(r)
	local x1, y1 = self:centerX(), self:centerY()
	local x2 = r:is(Rect) and r:centerX() or r.x
	local y2 = r:is(Rect) and r:centerY() or r.y

	return lume.angle(self.x + self.w / 2, self.y + self.h / 2, r.x + (r.w and r.w / 2 or 0), r.y + (r.h and r.h / 2 or 0))
end

function Rect:_str()
	return Rect.super._str(self) .. ", width: " .. self.width .. ", height: " .. self.height
end

function Rect:__tostring()
	return lume.tostring(self, "Rect")
end