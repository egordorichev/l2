 component = rect:extend()

local normal = 0
local hovered = 1
local clicked = 2

function component:new(x, y, w, h)
	component.super.new(self, x, y, w, h)

	self.state = normal
	self.onClickCallback = function() end
	self.onHoverCallback = function() end
	self.onMouseOutCallback = function() end
end

function component:updateAndDraw()
	self:update()
	self:draw()
end

function component:draw()

end

function component:update() -- doesn't work: fixme
	local x, y = camera.mapMousePosition()

	if self:containsPoint(x, y) then
		if love.mouse.isDown(1) then
			if self.state ~= clicked then
				self.state = clicked
				self:onStateChange()
			end
		else
			if self.state ~= hovered then
				self.state = hovered
				self:onStateChange()
			end
		end
	elseif self.state ~= normal then
		self.state = normal
		self:onStateChange()
	end
end

function component:onStateChange()
	if self.state == component.clicked then
		self:onClickCallback(self)
	elseif self.state == component.hovered then
		self:onHoverCallback(self)
	else
		self:onMouseOutCallback(self)
	end
end

function component:onClick()

end

function component:onHover()

end

function component:onMouseOut()

end