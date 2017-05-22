ingame = state:extend()

function ingame:init()
    input.register({
		[ "debug" ] = { "f1" },
		[ "left" ] = { "a", "left" },
		[ "right" ] = { "d", "right" },
		[ "up" ] = { "w", "up" },
		[ "down" ] = { "s", "down" },
	})
end

function ingame:draw()
    love.graphics.rectangle("fill", 10, 10, 100, 100)
end

function ingame:update(dt)

end