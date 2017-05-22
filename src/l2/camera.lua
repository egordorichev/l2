camera = {}

camera.x = 0
camera.y = 0

function camera.set()
    love.graphics.push()
    love.graphics.translate(-camera.x, -camera.y)
end

function camera.unset()
    love.graphics.pop()
end

function camera.mapMousePosition()
    local scale = 1 / game.scale
	return love.mouse.getX() * scale + camera.x, love.mouse.getY() * scale + camera.y
end