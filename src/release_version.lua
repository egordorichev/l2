local otenone = require "lib.o-ten-one"
local splash
local splashIsDone = false

function love.load()
	splash = otenone.new({
		background = { 0, 0, 0 }
	})

	splash.onDone = function ()
		splashIsDone = true
		game:init(menu)
	end
end

function love.draw()
	if splashIsDone then

	else
		splash:draw(dt)
	end
end

function love.update(dt)
	if splashIsDone then

	else
		splash:update(dt)
	end

	libs.update(dt)
end

function love.quit()
	game:save()
end