ingame = state:extend()
ingame_canvas = nil

function ingame:init()
    input.register({
		[ "debug" ] = { "f1" },
		[ "left" ] = { "a", "left" },
		[ "right" ] = { "d", "right" },
		[ "up" ] = { "w", "up" },
		[ "down" ] = { "s", "down" },
	})

    self.ui = uiManager()

    self.ui:add(button("shoot", 2, 2, 48, 14):onClick(function(b)
		print("test")
	end))

    self.ui:add(buttonSelect({ "one", "another", "third" }, 160 - 50, 2, 48, 14):onChange(function(s)
        print(s:getVariant())
    end))

    game.scale = 3
    ingame_canvas = love.graphics.newCanvas(game.width / game.scale, game.height / game.scale)
    ingame_canvas:setFilter("nearest", "nearest")

    love.graphics.setBackgroundColor(255, 255, 255)
end

function ingame:draw()
    love.graphics.setCanvas(ingame_canvas)
    love.graphics.clear()

    self.ui:draw()

    love.graphics.setCanvas()
    love.graphics.draw(ingame_canvas, 0, 0, 0, game.scale, game.scale)
end

function ingame:update(dt)

end