component = rect:extend()

component.normal = 0
component.hovered = 1
component.clicked = 2

function component:new(x, y, w, h)
	component.super.new(self, x, y, w, h)

	self.state = component.normal
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

function component:update()
	local x, y = input.mapMousePosition()

	if self:containsPoint(x, y) then
		if love.mouse.isDown(1) then
			if self.state ~= component.clicked then
				self.state = component.clicked
				self:onStateChange()
			end
		else
			if self.state ~= component.hovered then
				self.state = component.hovered
				self:onStateChange()
			end
		end
	elseif self.state ~= component.normal then
		self.state = component.normal
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