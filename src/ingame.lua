ingame = state:extend()

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
        -- print(s:getVariant())
    end))
end

function ingame:draw()
    self.ui:draw()
end

function ingame:update(dt)

end