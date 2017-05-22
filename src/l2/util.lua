util = {}

util.white = { 255, 255, 255 }
util.black = { 0, 0, 0 }

function util.drawTextWithStroke(text, x, y, color, stroke)
	color = color or util.white
	stroke = stroke or util.black

	local r, g, b, a = love.graphics.getColor()

	love.graphics.setColor(stroke)

	for j = -1, 1 do
		for i = -1, 1 do
			love.graphics.print(text, x + i, y + j)
		end
	end

	love.graphics.setColor(color)
	love.graphics.print(text, x, y)

	love.graphics.setColor(r, g, b, a)
end