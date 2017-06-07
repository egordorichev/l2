function love.load()
	game:init(ingame())
end

function love.draw()
	game:draw()
end

function love.update(dt)
	libs.update(dt)
	game:update(dt)
end

function love.quit()
	game:save()
end