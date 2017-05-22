button = component:extend()

function button:new(label, x, y, w, h)
	button.super.new(self, x, y, w, h)

	self:setLabel(label)

	self.texture = self.texture
	self.quads = {}

	table.insert(self.quads, love.graphics.newQuad(0, 0, 2, 2, 12, 4))
	table.insert(self.quads, love.graphics.newQuad(2, 0, 2, 2, 12, 4))
	table.insert(self.quads, love.graphics.newQuad(0, 2, 2, 2, 12, 4))
	table.insert(self.quads, love.graphics.newQuad(2, 2, 2, 2, 12, 4))

	table.insert(self.quads, love.graphics.newQuad(4, 0, 2, 2, 12, 4))
	table.insert(self.quads, love.graphics.newQuad(6, 0, 2, 2, 12, 4))
	table.insert(self.quads, love.graphics.newQuad(4, 2, 2, 2, 12, 4))
	table.insert(self.quads, love.graphics.newQuad(6, 2, 2, 2, 12, 4))

	table.insert(self.quads, love.graphics.newQuad(8, 0, 2, 2, 12, 4))
	table.insert(self.quads, love.graphics.newQuad(10, 0, 2, 2, 12, 4))
	table.insert(self.quads, love.graphics.newQuad(8, 2, 2, 2, 12, 4))
	table.insert(self.quads, love.graphics.newQuad(10, 2, 2, 2, 12, 4))

	self.texture = cache.load("data/images/button.png")
end

function button:setLabel(label)
	self.label = label
	self.labelPosition = vector(lume.round(self.x + (self.w - game.font:getWidth(self.label)) / 2), lume.round(self.y + (self.h - 5) / 2) - 2)
end

function button:draw()
	if self.state == component.clicked then
		self:drawFrom(1)
	elseif self.state == component.hovered then
		self:drawFrom(5)
	else
		self:drawFrom(9)
	end

	love.graphics.setShader() -- HERE!
	util.drawTextWithStroke(self.label, self.labelPosition.x, self.labelPosition.y)
	love.graphics.setShader(pallete.shader) -- HERE!
end

function button:drawFrom(from)
	love.graphics.draw(self.texture, self.quads[from], self.x, self.y)
	love.graphics.draw(self.texture, self.quads[from + 1], self.x + 2, self.y, 0, (self.w - 6) / 2, 1)
	love.graphics.draw(self.texture, self.quads[from], self.x + self.w - 2, self.y, 0, -1, 1)
	love.graphics.draw(self.texture, self.quads[from + 2], self.x, self.y + 2, 0, 1, (self.h - 6) / 2)
	love.graphics.draw(self.texture, self.quads[from + 2], self.x + self.w - 2, self.y + 2, 0, -1, (self.h - 6) / 2)
	love.graphics.draw(self.texture, self.quads[from], self.x, self.y + self.h - 2, 0, 1, -1)
	love.graphics.draw(self.texture, self.quads[from + 1], self.x + 2, self.y + self.h - 2, 0, (self.w - 6) / 2, -1)
	love.graphics.draw(self.texture, self.quads[from], self.x + self.w - 2, self.y + self.h - 2, 0, -1, -1)
	love.graphics.draw(self.texture, self.quads[from + 3], self.x + 2, self.y + 2, 0, (self.w - 6) / 2, (self.h - 6) / 2)
end

function button:onClick(callback)
	self.onClickCallback = callback
	return self
end

function button:onHover(callback)
	self.onHoverCallback = callback
	return self
end

function button:onMouseOut(callback)
	self.onMouseOutCallback = callback
	return self
end