local otenone = require "lib.o-ten-one"
local splash

function love.load()
	splash = otenone.new({
		background = { 0, 0, 0 }
	})
end

function love.draw()
	splash:draw(dt)

end

function love.update(dt)
	splash:update(dt)
	libs.update(dt)
end

function love.quit()

end